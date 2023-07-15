import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  TitleText({required this.title,Key? key}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
              fontSize: 50,
              color: Colors.white,
              fontWeight: FontWeight.bold
          )
        )
      ),
    );
  }
}
