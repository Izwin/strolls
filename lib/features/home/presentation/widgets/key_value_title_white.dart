import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'key_value_title.dart';

class KeyValueTitleProfile extends StatelessWidget {
  const KeyValueTitleProfile({required this.title,required this.value,Key? key}) : super(key: key);

  final String title,value;
  @override
  Widget build(BuildContext context) {
    return KeyValueTitle(title: title, value: value,titleTextStyle: TextStyle(
        fontSize: 12,
        color: Colors.white.withOpacity(0.75),
        fontWeight: FontWeight.w400
    ),textTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFFFFE5BF),
        fontWeight: FontWeight.w500
    ),
    );
  }
}
