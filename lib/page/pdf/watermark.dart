import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'dart:async';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pick_or_save/pick_or_save.dart';

class watermark extends StatefulWidget {
  const watermark({Key? key}) : super(key: key);

  @override
  State<watermark> createState() => _watermarkState();
}

class _watermarkState extends State<watermark> {
  final _pdfManipulatorPlugin = PdfManipulator();
  final _pickOrSavePlugin = PickOrSave();

  bool _isBusy = false;
  final bool _localOnly = false;
  final bool getCachedFilePath = false;
  List<bool> isSelected = [true, false];

  String? _pickedFilePathForWatermarkingPDF;
  String? _watermarkedPDFPath;
  String watermarkText = "My Watermark";
  var text;

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

  Future<String?> _pdfWatermark(PDFWatermarkParams params) async {
    String? result;
    try {
      result = await _pdfManipulatorPlugin.pdfWatermark(params: params);
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
            title: const Text('Watermark PDF'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 15.0),
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
                                mimeTypesFilter: ["application/pdf"],
                                allowedExtensions: [".pdf"],
                              );

                              List<String>? result = await _filePicker(params);

                              if (result != null && result.isNotEmpty) {
                                setState(() {
                                  _pickedFilePathForWatermarkingPDF = result[0];
                                });
                              }
                            },
                      child: const Text('Pick PDF file')),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      hintText: 'Enter text to watermark',
                    ),
                    onChanged: (value) => text = value,
                  ),
                  ElevatedButton(
                      child: const Text('Set Watermark'),
                      onPressed: () async {
                        setState(() {
                          watermarkText = text;
                        });
                      }),
                  ElevatedButton(
                      onPressed: _pickedFilePathForWatermarkingPDF == null
                          ? null
                          : () async {
                              final params = PDFWatermarkParams(
                                pdfPath: _pickedFilePathForWatermarkingPDF!,
                                text: watermarkText,
                              );

                              String? result = await _pdfWatermark(params);

                              if (result != null && result.isNotEmpty) {
                                setState(() {
                                  _watermarkedPDFPath = result;
                                });
                              }
                            },
                      child: const Text('Watermark PDF')),
                  Text(
                    "Watermark Text: $watermarkText",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  ElevatedButton(
                      onPressed: _watermarkedPDFPath == null
                          ? null
                          : _isBusy
                              ? null
                              : () async {
                                  final params = FileSaverParams(
                                    localOnly: _localOnly,
                                    saveFiles: [
                                      SaveFileInfo(
                                          filePath: _watermarkedPDFPath,
                                          fileName: "Watermarked PDF.pdf")
                                    ],
                                  );

                                  List<String>? result =
                                      await _fileSaver(params);
                                },
                      child: const Text('Save watermarked PDF')),
                ],
              ),
            ),
          ),
        ));
  }
}
