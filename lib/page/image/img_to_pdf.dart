import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'dart:async';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pick_or_save/pick_or_save.dart';

import '../pdf_screen.dart';

class img_to_pdf extends StatefulWidget {
  const img_to_pdf({Key? key}) : super(key: key);

  @override
  State<img_to_pdf> createState() => _img_to_pdfState();
}

class _img_to_pdfState extends State<img_to_pdf> {
  final _pdfManipulatorPlugin = PdfManipulator();
  final _pickOrSavePlugin = PickOrSave();

  bool _isBusy = false;
  final bool _localOnly = false;
  final bool getCachedFilePath = false;
  List<bool> isSelected = [true, false];

  List<String>? _pickedFilePathsForImagesToPDF;
  List<String>? _imagesToPDFPath;
  bool createSinglePdf = true;
  var file_name;

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

  Future<List<String>?> _imagesToPdf(ImagesToPDFsParams params) async {
    List<String>? result;
    try {
      result = await _pdfManipulatorPlugin.imagesToPdfs(params: params);
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
              title: const Text('Image to PDF'),
            ),
            body: Container(
              color: Colors.white,
              child: Center(
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0* MediaQuery.of(context).size.width/375.0,
                      vertical: 200.0* MediaQuery.of(context).size.height/812.0,
                    ),
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: _isBusy
                                ? null
                                : () async {
                                    final params = FilePickerParams(
                                      localOnly: _localOnly,
                                      getCachedFilePath: isSelected[1],
                                      mimeTypesFilter: [
                                        "image/jpeg",
                                        "image/jpg",
                                        "image/png",
                                        "image/bmp",
                                        "image/wmf",
                                        "image/tiff",
                                        "image/g3fax",
                                        "image/x-jbig2"
                                      ],
                                      enableMultipleSelection: true,
                                    );

                                    List<String>? result =
                                        await _filePicker(params);

                                    if (result != null && result.isNotEmpty) {
                                      setState(() {
                                        _pickedFilePathsForImagesToPDF = result;
                                      });
                                    }

                                  },
                            child: const Text('Pick image files')),
                        ElevatedButton(
                            onPressed: _pickedFilePathsForImagesToPDF == null
                                ? null
                                : () async {
                                    final params = ImagesToPDFsParams(
                                      imagesPaths: _pickedFilePathsForImagesToPDF!,
                                      createSinglePdf: createSinglePdf,
                                    );

                                    List<String>? result =
                                        await _imagesToPdf(params);

                                    if (result != null && result.isNotEmpty) {
                                      setState(() {
                                        _imagesToPDFPath = result;
                                      });
                                    }
                                    },
                            child: const Text('Convert images to PDF')),

                        ElevatedButton(
                            onPressed: _imagesToPDFPath == null
                                ? null
                                : _isBusy
                                    ? null
                                    : () async {
                                        final params = FileSaverParams(
                                          localOnly: _localOnly,
                                          saveFiles: List.generate(
                                              _imagesToPDFPath!.length,
                                              (index) => SaveFileInfo(
                                                  filePath:
                                                      _imagesToPDFPath![index],
                                                  fileName:
                                                      "Image ${index + 1} PDF.pdf")),
                                        );

                                        List<String>? result =
                                            await _fileSaver(params);


                                      },
                            child: const Text('Save PDF')),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}



