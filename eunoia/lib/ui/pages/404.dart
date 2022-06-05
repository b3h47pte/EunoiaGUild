import 'package:flutter/material.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This is Kami\'s Fault. I have no further information.',
          style: TextStyle(
            fontSize: 40.0,
          )
        ),
      )
    );
  }
}