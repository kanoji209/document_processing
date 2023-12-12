import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'dart:async';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pick_or_save/pick_or_save.dart';

class edit_pdf extends StatefulWidget {
  const edit_pdf({Key? key}) : super(key: key);

  @override
  State<edit_pdf> createState() => _edit_pdfState();
}

class _edit_pdfState extends State<edit_pdf> {
  final _pdfManipulatorPlugin = PdfManipulator();
  final _pickOrSavePlugin = PickOrSave();

  bool _isBusy = false;
  final bool _localOnly = false;
  final bool getCachedFilePath = false;
  List<bool> isSelected = [true, false];

  String? _pickedFilePathForRotateDeleteReorder;
  String? _pdfPageRotatorDeleterReorderPath;
  List<PageRotationInfo> pagesRotationInfo = [
    PageRotationInfo(pageNumber: 1, rotationAngle: 0)
  ];
  List<int> pageNumbersForDeleter = [];
  List<int>? pageNumbersForReorder = [];
  int selectedRotationAngle=0;


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

  Future<String?> _pdfPageRotatorDeleterReorder(
      PDFPageRotatorDeleterReorderParams params) async {
    String? result;
    try {
      result = await _pdfManipulatorPlugin.pdfPageRotatorDeleterReorder(
          params: params);
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
              title: const Text('Edit PDF'),
            ),
            resizeToAvoidBottomInset: false,
            body: Container(
                color: Colors.white,
                child: Center(
                    child: Card(
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
                                          mimeTypesFilter: [
                                            "application/pdf"
                                          ],
                                          allowedExtensions: [".pdf"],
                                        );

                                        List<String>? result =
                                            await _filePicker(params);

                                        if (result != null &&
                                            result.isNotEmpty) {
                                          setState(() {
                                            _pickedFilePathForRotateDeleteReorder =
                                                result[0];
                                          });
                                        }
                                      },
                                child: const Text('Pick PDF file')),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Enter Detail for page rotation"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(15.0))),
                                        labelText: 'Page Number',
                                      ),
                                      onChanged: (pageNumberValue) {
                                        setState(() {
                                          pagesRotationInfo[0] = PageRotationInfo(
                                            pageNumber: int.parse(pageNumberValue),
                                            rotationAngle: selectedRotationAngle,
                                          );
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                DropdownButton<int>(
                                  elevation: 8,
                                  iconEnabledColor: Colors.lightBlue,
                                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                  value: selectedRotationAngle,
                                  onChanged: (newRotationAngle) {
                                    setState(() {
                                      selectedRotationAngle = newRotationAngle!;
                                      pagesRotationInfo[0] = PageRotationInfo(
                                        pageNumber: pagesRotationInfo[0].pageNumber,
                                        rotationAngle: selectedRotationAngle,
                                      );
                                    });
                                  },
                                  items: const [
                                    DropdownMenuItem<int>(
                                      value: 0,
                                      child: Text('No Rotation°'),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 90,
                                      child: Text('Clockwise 90°'),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: -90,
                                      child: Text('Anticlockwise -90°'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Enter page numbers to delete page"),
                            ),
                            TextField(
                              decoration: const InputDecoration(
                            border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0))),
              labelText: 'Enter Page Numbers',
                                hintText: '1,2,5,7,...'
                              ),
                              onChanged: (newPageNumbers) {
                                setState(() {
                                  List<String> pageNumberStrings = newPageNumbers.split(',');

                                  pageNumbersForDeleter = pageNumberStrings
                                      .map((pageNumberString) => int.tryParse(pageNumberString))
                                      .where((pageNumber) => pageNumber != null)
                                      .toList()
                                      .cast<int>();
                                });
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Enter page number to Reorder PDF"),
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                                labelText: "Enter Page Numbers",
                                hintText: '1,4,3,5,...'
                              ),
                              onChanged: (newPageNumbers) {
                                setState(() {
                                  List<String> pageNumberStrings = newPageNumbers.split(',');

                                  pageNumbersForReorder = pageNumberStrings
                                      .map((pageNumberString) => int.tryParse(pageNumberString))
                                      .where((pageNumber) => pageNumber != null)
                                      .toList()
                                      .cast<int>();
                                });
                              },
                            ),
                            ElevatedButton(
                                onPressed:
                                    _pickedFilePathForRotateDeleteReorder ==
                                            null
                                        ? null
                                        : () async {
                                            final params =
                                                PDFPageRotatorDeleterReorderParams(
                                              pdfPath:
                                                  _pickedFilePathForRotateDeleteReorder!,
                                              pagesRotationInfo:
                                                  pagesRotationInfo,
                                              pageNumbersForDeleter:
                                                  pageNumbersForDeleter,
                                              pageNumbersForReorder:
                                                  pageNumbersForReorder,
                                            );

                                            String? result =
                                                await _pdfPageRotatorDeleterReorder(
                                                    params);

                                            if (result != null &&
                                                result.isNotEmpty) {
                                              setState(() {
                                                _pdfPageRotatorDeleterReorderPath =
                                                    result;
                                              });
                                            }
                                          },
                                child: const Text(
                                    'Rotate, Delete, Reorder PDF pages')),
                            Text(
                              "Deleted Page: $pageNumbersForDeleter\nReordered Page: $pageNumbersForReorder",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            ElevatedButton(
                                onPressed:
                                    _pdfPageRotatorDeleterReorderPath ==
                                            null
                                        ? null
                                        : _isBusy
                                            ? null
                                            : () async {
                                                final params =
                                                    FileSaverParams(
                                                  localOnly: _localOnly,
                                                  saveFiles: [
                                                    SaveFileInfo(
                                                        filePath:
                                                            _pdfPageRotatorDeleterReorderPath,
                                                        fileName:
                                                            "Rotated, Deleted, Reordered PDF.pdf")
                                                  ],
                                                );

                                                List<String>? result =
                                                    await _fileSaver(
                                                        params);
                                              },
                                child: const Text('Save PDF')),
                          ],
                        ),
                      ),
                    )))));
  }
}


