// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:demo/page/home_page.dart';
import 'package:demo/page/image_home.dart';
import 'package:demo/page/pdf_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Document Processing',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assests/playstore-modified.png",
          ),
        ),
        title: const Text('Document Processing'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: <Widget>[
          HomePage(),
          pdf_home(),
          image_home(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _currentPage,
        onTap: (int page) {
          _pageController.animateToPage(
            page,
            duration: Duration(milliseconds: 400),
            curve: Curves.bounceInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: 'PDF',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Image',
          ),
        ],
      ),
    );
  }
}