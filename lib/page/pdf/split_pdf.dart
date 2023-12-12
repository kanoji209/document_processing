import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'dart:async';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pick_or_save/pick_or_save.dart';

class split_pdf extends StatefulWidget {
  const split_pdf({Key? key}) : super(key: key);

  @override
  State<split_pdf> createState() => _split_pdfState();
}

class _split_pdfState extends State<split_pdf> {
  final _pdfManipulatorPlugin = PdfManipulator();
  final _pickOrSavePlugin = PickOrSave();

  bool _isBusy = false;
  final bool _localOnly = false;
  final bool getCachedFilePath = false;
  List<bool> isSelected = [true, false];

  String? _pickedFilePathForSplit;
  List<String>? _splitPDFPaths;
  int pageCount = 0;
  List<int> pageNumbers = [2, 5, 9];
  String pageRange = "1-3,5-8";

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

  Future<List<String>?> _splitPDF(PDFSplitterParams params) async {
    List<String>? result;
    try {
      result = await _pdfManipulatorPlugin.splitPDF(params: params);
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
    title: const Text('Split Pdf'),
    ),

      body: SingleChildScrollView(
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
                        mimeTypesFilter: ["application/pdf"],
                        allowedExtensions: [".pdf"],
                      );

                      List<String>? result =
                      await _filePicker(params);

                      if (result != null && result.isNotEmpty) {
                        setState(() {
                          _pickedFilePathForSplit = result[0];
                        });
                      }

                    },
                    child: const Text('Pick single PDF file')),
                const Divider(),
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
                            labelText: 'Page Count',
                          ),
                          onChanged: (value) {
                            pageCount=int.tryParse(value) ?? 0;
                            })
                        ),
                      ),

                    ElevatedButton(
                        onPressed: _pickedFilePathForSplit == null
                            ? null
                            : () async {
                          final params = PDFSplitterParams(
                            pdfPath: _pickedFilePathForSplit!,
                            pageCount: pageCount,
                          );

                          List<String>? result =
                          await _splitPDF(params);

                          if (result != null && result.isNotEmpty) {
                            setState(() {
                              _splitPDFPaths = result;
                            });
                          }


                        },
                        child: const Text('Split PDF by page count')),
                  ],
                ),
                Text(
                  "pageCount: $pageCount",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                              labelText: "Enter Page Numbers",
                              hintText: '1,4,5,...'
                          ),
                          onChanged: (newPageNumbers) {
                            setState(() {
                              List<String> pageNumberStrings = newPageNumbers.split(',');

                              pageNumbers = pageNumberStrings
                                  .map((pageNumberString) => int.tryParse(pageNumberString))
                                  .where((pageNumber) => pageNumber != null)
                                  .toList()
                                  .cast<int>();
                            });
                          },
                        ),
                      ),

                    ),
                    ElevatedButton(
                        onPressed: _pickedFilePathForSplit == null
                            ? null
                            : () async {
                          final params = PDFSplitterParams(
                            pdfPath: _pickedFilePathForSplit!,
                            pageNumbers: pageNumbers,
                          );

                          List<String>? result =
                          await _splitPDF(params);

                          if (result != null && result.isNotEmpty) {
                            setState(() {
                              _splitPDFPaths = result;
                            });
                          }


                        },
                        child: const Text('Split PDF by page numbers')),
                  ],
                ),
                Text(
                  "pageNumbers: $pageNumbers",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Divider(),
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
                            labelText: 'Page Range',
                            hintText: '1-3,5-8'
                          ),
                          onChanged: (value) {
                            setState(() {
                              pageRange=value;
                            });
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: _pickedFilePathForSplit == null
                            ? null
                            : () async {
                          final params = PDFSplitterParams(
                            pdfPath: _pickedFilePathForSplit!,
                            pageRange: pageRange,
                          );

                          List<String>? result =
                          await _splitPDF(params);

                          if (result != null && result.isNotEmpty) {
                            setState(() {
                              _splitPDFPaths = result;
                            });
                          }


                        },
                        child: const Text('Split PDF by page range')),
                  ],
                ),
                Text(
                  "pageRange: $pageRange",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Divider(),
                ElevatedButton(
                    onPressed: _splitPDFPaths == null
                        ? null
                        : _isBusy
                        ? null
                        : () async {
                      final params = FileSaverParams(
                        localOnly: _localOnly,
                        saveFiles: List.generate(
                            _splitPDFPaths!.length,
                                (index) => SaveFileInfo(
                                filePath:
                                _splitPDFPaths![index],
                                fileName:
                                "Split PDF ${index + 1}.pdf")),
                      );

                      List<String>? result =
                      await _fileSaver(params);


                    },
                    child: const Text('Save split PDFs')),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

