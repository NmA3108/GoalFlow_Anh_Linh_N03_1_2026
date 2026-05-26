import 'package:flutter/material.dart';

class MyContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Page"),
      ),
      body: Center(
        child: Text(
          "This is Contact Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}