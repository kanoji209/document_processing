import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'dart:async';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pick_or_save/pick_or_save.dart';

class merge_pdf extends StatefulWidget {
  const merge_pdf({Key? key}) : super(key: key);

  @override
  State<merge_pdf> createState() => _merge_pdfState();
}

class _merge_pdfState extends State<merge_pdf> {
  final _pdfManipulatorPlugin = PdfManipulator();
  final _pickOrSavePlugin = PickOrSave();

  bool _isBusy = false;
  final bool _localOnly = false;
  final bool getCachedFilePath = false;
  List<bool> isSelected = [true, false];

  List<String>? _pickedFilesPathsForMerge;
  String? _mergedPDFsPath;

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

  Future<String?> _mergePDFs(PDFMergerParams params) async {
    String? result;
    try {
      result = await _pdfManipulatorPlugin.mergePDFs(params: params);
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
            title: const Text('Merge Pdf'),
          ),
          body: Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.0* MediaQuery.of(context).size.width/375.0,
                  vertical: 150.0* MediaQuery.of(context).size.height/812.0,
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: _isBusy
                              ? null
                              : () async {
                                  final params = FilePickerParams(
                                    localOnly: _localOnly,
                                    getCachedFilePath: isSelected[1],
                                    enableMultipleSelection: true,
                                    mimeTypesFilter: ["application/pdf"],
                                    allowedExtensions: [".pdf"],
                                  );

                                  List<String>? result =
                                      await _filePicker(params);

                                  if (result != null && result.isNotEmpty) {
                                    setState(() {
                                      _pickedFilesPathsForMerge = result;
                                    });
                                  }


                                },
                          child: const Text('Pick PDF files')),
                      ElevatedButton(
                          onPressed: _pickedFilesPathsForMerge == null
                              ? null
                              : _pickedFilesPathsForMerge!.length < 2
                                  ? null
                                  : () async {
                                      final params = PDFMergerParams(
                                        pdfsPaths: _pickedFilesPathsForMerge!,
                                      );

                                      String? result = await _mergePDFs(params);

                                      if (result != null && result.isNotEmpty) {
                                        setState(() {
                                          _mergedPDFsPath = result;
                                        });
                                      }


                                    },
                          child: const Text('Merge')),
                      ElevatedButton(
                          onPressed: _mergedPDFsPath == null
                              ? null
                              : _isBusy
                                  ? null
                                  : () async {
                                      final params = FileSaverParams(
                                          localOnly: _localOnly,
                                          saveFiles: [
                                            SaveFileInfo(
                                                filePath: _mergedPDFsPath,
                                                fileName: "Merged PDF.pdf")
                                          ]);

                                      List<String>? result =
                                          await _fileSaver(params);


                                    },
                          child: const Text('Save merged PDF')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

