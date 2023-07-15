import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyValueTitle extends StatelessWidget {
  const KeyValueTitle({required this.title,required this.value,Key? key, this.titleTextStyle, this.textTextStyle}) : super(key: key);

  final String title,value;
  final TextStyle? titleTextStyle;
  final TextStyle? textTextStyle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title: ",
            style: titleTextStyle != null ? titleTextStyle : TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.w400)),
        Text(value,
            style: textTextStyle != null ? textTextStyle : TextStyle(
                fontSize: 12,
                color: Color(0xFFD0BDA1),
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
