import 'package:flutter/material.dart';

class convert_pdf extends StatelessWidget {
  const convert_pdf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Processing'),
      ),
      body: Center(
        child: (
            Text("This is convert pdf into another format page", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
        ),
      ),
    );
  }
}
