import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  WhiteButton({required this.text,this.height = 60, this.fontSize = 30,required this.onTap,Key? key}) : super(key: key);

  String text;
  Function onTap;
  double height;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          onTap.call();
        },
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
