import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedAvatar extends StatelessWidget {
  RoundedAvatar({this.size = 120,required this.url, super.key});

  final String url;

  double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.yellow),
        child: Image.network(
          url,
          errorBuilder: (context, obj, _) {
            return Image.network(
                "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",fit: BoxFit.cover,);
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
