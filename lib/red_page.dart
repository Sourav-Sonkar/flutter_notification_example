import 'package:flutter/material.dart';

class RedPage extends StatelessWidget {
   const RedPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
     backgroundColor: Colors.red,
      body: Center(
        child: Text('Red Page'),
      ),
    );
  }
}