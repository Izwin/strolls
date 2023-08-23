import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  TitleText({required this.title,this.height,Key? key}) : super(key: key);
  String title;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50,height: height),
    );
  }
}
