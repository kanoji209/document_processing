import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'dart:async';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pick_or_save/pick_or_save.dart';

class compress_pdf extends StatefulWidget {
  const compress_pdf({Key? key}) : super(key: key);

  @override
  State<compress_pdf> createState() => _compress_pdfState();
}

class _compress_pdfState extends State<compress_pdf> {
  final _pdfManipulatorPlugin = PdfManipulator();
  final _pickOrSavePlugin = PickOrSave();

  bool _isBusy = false;
  final bool _localOnly = false;
  final bool getCachedFilePath = false;
  List<bool> isSelected = [true, false];

  String? _pickedFilePathForCompressingPDF;
  String? _compressedPDFPath;
  int imageQuality =70 ;
  double imageScale = 0.5;
  FileMetadata? orginal;
  FileMetadata? compress;
  String? orignal_size;
  String? compress_size;

  Future<List<String>?> _filePicker(FilePickerParams params) async {
    List<String>? result;
    try {
      setState(() {
        _isBusy = true;
      });
      result = await _pickOrSavePlugin.filePicker(params: params);
    } on PlatformException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    if (!mounted) return result;
    setState(() {
      _isBusy = false;
    });
    return result;
  }

  Future<List<String>?> _fileSaver(FileSaverParams params) async {
    List<String>? result;
    try {
      setState(() {
        _isBusy = true;
      });
      result = await _pickOrSavePlugin.fileSaver(params: params);
    } on PlatformException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    if (!mounted) return result;
    setState(() {
      _isBusy = false;
    });
    return result;
  }

  Future<String?> _pdfCompressor(PDFCompressorParams params) async {
    String? result;
    try {
      result = await _pdfManipulatorPlugin.pdfCompressor(params: params);
    } on PlatformException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    return result;
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Compress Pdf'),
      ),
      body: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: _isBusy
                        ? null
                        : () async {
                      final params = FilePickerParams(
                        localOnly: _localOnly,
                        getCachedFilePath: isSelected[1],
                        mimeTypesFilter: ["application/pdf"],
                        allowedExtensions: [".pdf"],
                      );

                      List<String>? result =
                      await _filePicker(params);

                      if (result != null && result.isNotEmpty) {
                        setState(() {
                          _pickedFilePathForCompressingPDF =
                          result[0];
                        });
                      }
                      orginal = await PickOrSave().fileMetaData(
                        params: FileMetadataParams(filePath: _pickedFilePathForCompressingPDF!),
                      );
                      orignal_size=filesize(orginal!.size);
                    },
                    child: const Text('Pick PDF')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Size: $orignal_size"),
                ),
                const Text("Set Quality"),
                Slider(
                 value: imageQuality.toDouble(),
                 min:1.0,
                    max:100.0,
                  activeColor:Colors.green,
                  inactiveColor:Colors.grey,
                  label:'Set Quality',
                  onChanged:(double newValue){
                   setState(() {
                     imageQuality=newValue.round();
                   });
                  },
                semanticFormatterCallback: (double newValue) {
                return '${newValue.round()} dollars';
    }),

                ElevatedButton(
                    onPressed: _pickedFilePathForCompressingPDF == null ? null : () async {
                      final params = PDFCompressorParams(
                        pdfPath: _pickedFilePathForCompressingPDF!,
                        imageQuality: imageQuality,
                        imageScale: imageScale,
                      );

                      String? result = await _pdfCompressor(params);

                      if (result != null && result.isNotEmpty) {
                        setState(() {
                          _compressedPDFPath = result;
                        });
                      }
                      compress = await PickOrSave().fileMetaData(
                        params: FileMetadataParams(filePath: _compressedPDFPath!),
                      );
                      compress_size=filesize(compress!.size);

                    },
                    child: const Text('Compress PDF')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Quality: $imageQuality",
                    ),
                    Text("\tSize: $compress_size")
                  ],
                ),
                ElevatedButton(
                    onPressed: _compressedPDFPath == null
                        ? null
                        : _isBusy
                        ? null
                        : () async {
                      final params = FileSaverParams(
                        localOnly: _localOnly,
                        saveFiles: [
                          SaveFileInfo(
                              filePath: _compressedPDFPath,
                              fileName: "Compressed PDF.pdf")
                        ],
                      );

                      List<String>? result =
                      await _fileSaver(params);

                    },
                    child: const Text('Save compressed PDF')),
              ],
            ),
          ),
        ),
    ),
    );
  }
}
