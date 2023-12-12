import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_or_save/pick_or_save.dart';
import 'package:filesize/filesize.dart';


class image_compress extends StatefulWidget {
  const image_compress({Key? key}) : super(key: key);

  @override
  State<image_compress> createState() => _image_compressState();
}

class _image_compressState extends State<image_compress> {
  Uint8List? originalImage;
  Uint8List? compressedImage;
  int imgQuality = 70;
  String? compressed_size;
  String? orignal_size;

  final _pickOrSavePlugin = PickOrSave();

  bool _isBusy = false;
  final bool _localOnly = false;
  final bool getCachedFilePath = false;


  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      originalImage = img;
    });
    orignal_size=filesize(originalImage?.length) ;
  }

  Future compressImage() async {
    if (originalImage == null) return null;

    final compressedFile = await FlutterImageCompress.compressWithList(
      originalImage!,
      quality: imgQuality,
    );

    setState(() {
      compressedImage = compressedFile;
    });
    compressed_size = filesize(compressedFile.length);

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

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Compress Image'),
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Original Image",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          originalImage != null
                              ? Image(
                                  image: MemoryImage(originalImage!),
                                  height: 150,
                                )
                              : const Icon(Icons.image),
                          Text("Size: $orignal_size"),
                          ElevatedButton(
                              onPressed: selectImage,
                              child: const Text("Pick Image"))
                        ],
                      )),
                ),
                SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Compress Image",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        compressedImage != null
                            ? Image(
                                image: MemoryImage(compressedImage!),
                                height: 150,
                              )
                            : const Icon(Icons.image),
                        Padding(
                          padding:const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Set Quality : $imgQuality"),
                              Text("\tSize : $compressed_size"),
                            ],
                          ),
                        ),
                        Slider(
                            value: imgQuality.toDouble(),
                            min: 1.0,
                            max: 100.0,
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
                            label: 'Set Quality',
                            onChanged: (double newValue) {
                              setState(() {
                                imgQuality = newValue.round();
                              });
                            },
                            semanticFormatterCallback: (double newValue) {
                              return '${newValue.round()} dollars';
                            }),
                        ElevatedButton(
                            onPressed: compressImage,
                            child: const Text("Compress Image")
                        ),
                        ElevatedButton(
                            onPressed: compressedImage == null
                                ? null
                                : _isBusy
                                ? null
                                : () async {
                              final params = FileSaverParams(
                                localOnly: _localOnly,
                                saveFiles: [ SaveFileInfo(
                                        fileData: compressedImage,
                                        fileName: "Compressed Image.jpg")],
                              );

                              List<String>? result =
                              await _fileSaver(params);

                              if (mounted) {
                                callSnackBar(
                                    context: context,
                                    text: result.toString());
                              }
                            },
                            child: const Text('Save Images')),
                      ],
                    ),
                )
              ],
            ),
          ),
        ));
  }
}




callSnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
}
