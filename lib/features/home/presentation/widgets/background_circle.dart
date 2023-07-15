import 'dart:ui';

import 'package:flutter/cupertino.dart';

class BackgroundCircle extends StatelessWidget {
  double width;
  double height;

  BackgroundCircle({super.key, this.width = 300,this.height = 300});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFFE1412B), Color(0xFF0C0C0C)])),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
              tileMode: TileMode.clamp
          ),
          child: SizedBox(
            width: width,
            height: height,
          ),
        ),
      ],
    );
  }
}
