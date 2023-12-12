import 'package:flutter/material.dart';

class remove_bg extends StatelessWidget {
  const remove_bg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Processing'),
      ),
      body: Center(
        child: (
            Text("This is remove background page", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
        ),
      ),
    );
  }
}
