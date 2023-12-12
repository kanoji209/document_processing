import 'package:flutter/material.dart';

class extract_text extends StatelessWidget {
  const extract_text({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Processing'),
      ),
      body: Center(
        child: (
            Text("This is extract text from image page", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
        ),
      ),
    );
  }
}
