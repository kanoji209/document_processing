import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PDFScreen extends StatefulWidget {
  final String? path;
  final String? name;
  const PDFScreen({super.key, required this.path, this.name});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late PdfControllerPinch pdfPinchController;

  loadController() {
    pdfPinchController =
        PdfControllerPinch(document: PdfDocument.openFile(widget.path.toString()));
  }

  @override
  void initState(){
    super.initState();
    loadController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name.toString()),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: PdfViewPinch(controller: pdfPinchController,),
        floatingActionButton: FloatingActionButton.extended(onPressed: () {},
          label:Text("Save PDF"),
          icon: Icon(Icons.save),
        ),
    );
  }
}
