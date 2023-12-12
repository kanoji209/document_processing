import 'package:demo/page/pdf/compress_pdf.dart';
import 'package:demo/page/pdf/convert_pdf.dart';
import 'package:demo/page/pdf/edit_pdf.dart';
import 'package:demo/page/pdf/merge_pdf.dart';
import 'package:demo/page/pdf/protect_pdf.dart';
import 'package:demo/page/pdf/split_pdf.dart';
import 'package:demo/page/pdf/watermark.dart';
import 'package:flutter/material.dart';

class pdf_home extends StatelessWidget {
  const pdf_home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0* MediaQuery.of(context).size.width/375.0,
            vertical: 5.0* MediaQuery.of(context).size.height/812.0,
          ),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Container(
                height: MediaQuery.of(context).size.height*0.12,
                width: MediaQuery.of(context).size.width*0.12,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: const Icon(
                  Icons.compress,
                  color: Colors.white,
                ),
              ),
              title: const Text('Compress Pdf'),
              subtitle: const Text('Reduce your pdf size'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const compress_pdf()));
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0* MediaQuery.of(context).size.width/375.0,
            vertical: 5.0* MediaQuery.of(context).size.height/812.0,
          ),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Container(
                height:  MediaQuery.of(context).size.height*0.12,
                width: MediaQuery.of(context).size.width*0.12,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: const Icon(
                  Icons.branding_watermark,
                  color: Colors.white,
                ),
              ),
              title: const Text('Watermark Pdf'),
              subtitle: const Text('Add watermark in your pdf'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const watermark()));
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0* MediaQuery.of(context).size.width/375.0,
            vertical: 5.0* MediaQuery.of(context).size.height/812.0,
          ),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Container(
                height: MediaQuery.of(context).size.height*0.12,
                width: MediaQuery.of(context).size.width*0.12,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: const Icon(
                  Icons.splitscreen,
                  color: Colors.white,
                ),
              ),
              title: const Text('Split Pdf'),
              subtitle: const Text('Split one pdf into multiple pdf'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const split_pdf()));
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0* MediaQuery.of(context).size.width/375.0,
            vertical: 5.0* MediaQuery.of(context).size.height/812.0,
          ),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Container(
                height:  MediaQuery.of(context).size.height*0.12,
                width: MediaQuery.of(context).size.width*0.12,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.white,
                ),
              ),
              title: const Text('Merge Pdf'),
              subtitle: const Text('Merge Multiple pdf into one pdf'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const merge_pdf()));
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0* MediaQuery.of(context).size.width/375.0,
            vertical: 5.0* MediaQuery.of(context).size.height/812.0,
          ),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Container(
                height: MediaQuery.of(context).size.height*0.12,
                width: MediaQuery.of(context).size.width*0.12,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: const Icon(
                  Icons.edit_note,
                  color: Colors.white,
                ),
              ),
              title: const Text('Edit Pdf'),
              subtitle: const Text('Edit text, delete page, rotate etc.'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const edit_pdf()));
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0* MediaQuery.of(context).size.width/375.0,
            vertical: 5.0* MediaQuery.of(context).size.height/812.0,
          ),
          // child: Card(
          //   elevation: 2,
          //   child: ListTile(
          //     leading: Container(
          //       height:  MediaQuery.of(context).size.height*0.12,
          //       width: MediaQuery.of(context).size.width*0.12,
          //       decoration: const BoxDecoration(
          //           shape: BoxShape.circle, color: Colors.blue),
          //       child: const Icon(
          //         Icons.picture_as_pdf,
          //         color: Colors.white,
          //       ),
          //     ),
          //     title: const Text('Convert Pdf'),
          //     subtitle: const Text('Convert pdf into image'),
          //     trailing: const Icon(Icons.arrow_forward),
          //     onTap: () {
          //       Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => const convert_pdf()));
          //     },
          //   ),
          // ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0* MediaQuery.of(context).size.width/375.0,
            vertical: 5.0* MediaQuery.of(context).size.height/812.0,
          ),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Container(
                height:  MediaQuery.of(context).size.height*0.12,
                width: MediaQuery.of(context).size.width*0.12,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: const Icon(
                  Icons.key,
                  color: Colors.white,
                ),
              ),
              title: const Text('Protect Pdf'),
              subtitle: const Text('Set password on pdf'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const protect_pdf()));
              },
            ),
          ),
        ),
      ],
    ));
  }
}
