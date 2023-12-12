import 'package:flutter/material.dart';

import 'image/ImageCompress.dart';
import 'image/extract_text.dart';
import 'image/img_to_pdf.dart';
import 'image/remove_bg.dart';

class image_home extends StatefulWidget {
  const image_home({Key? key}) : super(key: key);

  @override
  State<image_home> createState() => _image_homeState();
}

class _image_homeState extends State<image_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (ListView(
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
                  height:  MediaQuery.of(context).size.height*0.12,
                  width: MediaQuery.of(context).size.width*0.12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                ),
                title: Text('Compress Image'),
                subtitle: Text('Reduce your image size'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => image_compress()));
                },
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 8.0* MediaQuery.of(context).size.width/375.0,
          //     vertical: 5.0* MediaQuery.of(context).size.height/812.0,
          //   ),
          //   child: Card(
          //     elevation: 2,
          //     child: ListTile(
          //       leading: Container(
          //         height:  MediaQuery.of(context).size.height*0.12,
          //         width: MediaQuery.of(context).size.width*0.12,
          //         decoration:
          //             BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          //         child: Icon(
          //           Icons.image_aspect_ratio_sharp,
          //           color: Colors.white,
          //         ),
          //       ),
          //       title: Text('Remove Background'),
          //       subtitle: Text('Remove image background'),
          //       trailing: Icon(Icons.arrow_forward),
          //       onTap: () {
          //         Navigator.of(context)
          //             .push(MaterialPageRoute(builder: (context) => remove_bg()));
          //       },
          //     ),
          //   ),
          // ),
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
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  child: Icon(
                    Icons.cabin,
                    color: Colors.white,
                  ),
                ),
                title: Text('Convert to Pdf'),
                subtitle: Text('Convert image into pdf'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => img_to_pdf()));
                },
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 8.0* MediaQuery.of(context).size.width/375.0,
          //     vertical: 5.0* MediaQuery.of(context).size.height/812.0,
          //   ),
          //   child: Card(
          //     elevation: 2,
          //     child: ListTile(
          //       leading: Container(
          //         height:  MediaQuery.of(context).size.height*0.12,
          //         width: MediaQuery.of(context).size.width*0.12,
          //         decoration:
          //             BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          //         child: Icon(
          //           Icons.text_format,
          //           color: Colors.white,
          //         ),
          //       ),
          //       title: Text('Extract Text'),
          //       subtitle: Text('Extract text from image'),
          //       trailing: Icon(Icons.arrow_forward),
          //       onTap: () {
          //         Navigator.of(context).push(
          //             MaterialPageRoute(builder: (context) => extract_text()));
          //       },
          //     ),
          //   ),
          // )
        ],
      )),
    );
  }
}
