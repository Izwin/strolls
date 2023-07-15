import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  WhiteButton({required this.text, required this.onTap,Key? key}) : super(key: key);

  String text;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          onTap.call();
        },
        child: Text(
          text,
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
