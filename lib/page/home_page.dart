// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:demo/page/pdf/compress_pdf.dart';
import 'package:demo/page/pdf/edit_pdf.dart';
import 'package:demo/page/pdf/merge_pdf.dart';
import 'package:demo/page/pdf/split_pdf.dart';
import 'package:flutter/material.dart';
import 'image/ImageCompress.dart';
import 'image/img_to_pdf.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 6.0* MediaQuery.of(context).size.width/375.0,
                vertical: 15.0* MediaQuery.of(context).size.height/812.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: MediaQuery.of(context).size.height*0.22,
                    child: InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => merge_pdf()));},
                      child: Card(
                        elevation: 3,
                        shadowColor: Colors.blueAccent,
                        child: Column(
                          children: [
                            Image.asset("assests/merge_pdf.png",height:  MediaQuery.of(context).size.height*0.15,),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            Text("Merge Pdf",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: MediaQuery.of(context).size.height*0.22,
                    child: InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => image_compress()));
                      },
                      child: Card(
                        elevation: 3,
                        shadowColor: Colors.blueAccent,
                        child: Column(
                          children: [
                            Image.asset("assests/resize_image.png",height:  MediaQuery.of(context).size.height*0.15,),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            Text("Compress Image",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 6.0* MediaQuery.of(context).size.width/375.0,
                vertical: 15.0* MediaQuery.of(context).size.height/812.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: MediaQuery.of(context).size.height*0.22,
                    child: InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => compress_pdf()));
                      },
                      child: Card(
                        elevation: 3,
                        shadowColor: Colors.blueAccent,
                        child: Column(
                          children: [
                            Image.asset("assests/compress_pdf.png",height: MediaQuery.of(context).size.height*0.15,),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            Text("Compress Pdf",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: MediaQuery.of(context).size.height*0.22,
                    child: InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => img_to_pdf()));},
                      child: Card(
                        elevation: 3,
                        shadowColor: Colors.blueAccent,
                        child: Column(
                          children: [
                            Image.asset("assests/images_to_pdf.jpeg",height: MediaQuery.of(context).size.height*0.15,),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            Text("Image to PDF",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 6.0* MediaQuery.of(context).size.width/375.0,
                vertical: 15.0* MediaQuery.of(context).size.height/812.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: MediaQuery.of(context).size.height*0.22,
                    child: InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => split_pdf()));
                      },
                      child: Card(
                        elevation: 3,
                        shadowColor: Colors.blueAccent,
                        child: Column(
                          children: [
                            Image.asset("assests/split_pdf.png",height:  MediaQuery.of(context).size.height*0.15,),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            Text("Split PDF",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: MediaQuery.of(context).size.height*0.22,
                    child: InkWell(
                      onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => edit_pdf()));},
                      child: Card(
                        elevation: 3,
                        shadowColor: Colors.blueAccent,
                        child: Column(
                          children: [
                            Image.asset("assests/edit_pdf.png",height:  MediaQuery.of(context).size.height*0.15,),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            Text("Edit Pdf",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
