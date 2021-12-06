import 'package:flutter/material.dart';

class GreenPage extends StatelessWidget {
   const GreenPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
     backgroundColor: Colors.green,
      body: Center(
        child: Text('Green Page'),
      ),
    );
  }
}