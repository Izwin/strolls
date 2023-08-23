import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  SubtitleText({required this.title,this.height,super.key});
  String title;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 36,height: height),
    );
  }
}
