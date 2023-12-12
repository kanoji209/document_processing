import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'dart:async';
import 'package:pdf_manipulator/pdf_manipulator.dart';
import 'package:pick_or_save/pick_or_save.dart';

class protect_pdf extends StatefulWidget {
  const protect_pdf({Key? key}) : super(key: key);

  @override
  State<protect_pdf> createState() => _protect_pdfState();
}

class _protect_pdfState extends State<protect_pdf> {
  final _pdfManipulatorPlugin = PdfManipulator();
  final _pickOrSavePlugin = PickOrSave();

  bool _isBusy = false;
  final bool _localOnly = false;
  final bool getCachedFilePath = false;
  List<bool> isSelected = [true, false];

  String? _encryptedPDFPath;
  String userPassword = "userpw";
  bool standardEncryptionAES128 = true;

  String? _pickedFile;
  String? _decryptedPDFPath;
  String userOrOwnerPassword = "userpw";
  var pass;

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

  Future<String?> _pdfEncryption(PDFEncryptionParams params) async {
    String? result;
    try {
      result = await _pdfManipulatorPlugin.pdfEncryption(params: params);
    } on PlatformException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<String?> _pdfDecryption(PDFDecryptionParams params) async {
    String? result;
    try {
      result = await _pdfManipulatorPlugin.pdfDecryption(params: params);
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
              title: const Text('Protect PDF'),
            ),
            resizeToAvoidBottomInset: false,
            body: Container(
                color: Colors.white,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0 * MediaQuery.of(context).size.width / 375.0,
                    vertical:
                        100.0 * MediaQuery.of(context).size.height / 812.0,
                  ),
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
                                          _pickedFile =
                                              result[0];
                                        });
                                      }
                                    },
                              child: const Text('Select PDF file')),
                          TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                              labelText: 'Password',
                              hintText: 'Enter Password',
                            ),
                            onChanged: (value) => pass = value,
                          ),
                          ElevatedButton(
                              onPressed: _pickedFile == null
                                  ? null
                                  : () async {
                                      final params = PDFEncryptionParams(
                                        pdfPath:
                                            _pickedFile!,
                                        userPassword: userPassword,
                                        standardEncryptionAES128:
                                            standardEncryptionAES128,
                                      );

                                      String? result =
                                          await _pdfEncryption(params);

                                      if (result != null && result.isNotEmpty) {
                                        setState(() {
                                          _encryptedPDFPath = result;
                                          userPassword=pass;
                                        });
                                      }
                                    },
                              child: const Text('Protect PDF')),

                          ElevatedButton(
                              onPressed: _pickedFile == null
                                  ? null
                                  : () async {
                                      final params = PDFDecryptionParams(
                                        pdfPath:
                                            _pickedFile!,
                                        password: userOrOwnerPassword,
                                      );

                                      String? result =
                                          await _pdfDecryption(params);

                                      if (result != null && result.isNotEmpty) {
                                        setState(() {
                                          _decryptedPDFPath = result;
                                          userOrOwnerPassword=pass;
                                        });
                                      }
                                    },
                              child: const Text('Decrypt PDF')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: _encryptedPDFPath == null
                                      ? null
                                      : _isBusy
                                      ? null
                                      : () async {
                                    final params = FileSaverParams(
                                      localOnly: _localOnly,
                                      saveFiles: [
                                        SaveFileInfo(
                                            filePath: _encryptedPDFPath,
                                            fileName: "Encrypted PDF.pdf")
                                      ],
                                    );

                                    List<String>? result =
                                    await _fileSaver(params);
                                  },
                                  child: const Text('Save Encrypted PDF')),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ElevatedButton(
                                    onPressed: _decryptedPDFPath == null
                                        ? null
                                        : _isBusy
                                            ? null
                                            : () async {
                                                final params = FileSaverParams(
                                                  localOnly: _localOnly,
                                                  saveFiles: [
                                                    SaveFileInfo(
                                                        filePath: _decryptedPDFPath,
                                                        fileName: "Decrypted PDF.pdf")
                                                  ],
                                                );

                                                List<String>? result =
                                                    await _fileSaver(params);
                                              },
                                    child: const Text('Save decrypted PDF')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )))));
  }
}
