import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  static const routeName = '/load';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
