import 'package:flutter/material.dart';

class TelaMobile extends StatelessWidget {
  const TelaMobile({ Key? key,  required this.tela, required this.body }) : super(key: key);
  
  final String tela;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFc9a556),
        title: Text(tela,textAlign: TextAlign.center,),
      
      ),
      body: body
    );
  }
}