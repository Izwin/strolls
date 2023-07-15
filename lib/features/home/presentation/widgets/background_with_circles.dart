import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'background_circle.dart';

class BackgroundWithCircles extends StatelessWidget {
  BackgroundWithCircles({Key? key,required this.child}) : super(key: key);
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Color(0xFF15010A)])),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ),
        Positioned(
          top: 110,
          right: -130,
          child: BackgroundCircle(),
        ),
        Positioned(
          bottom: 50,
          left: -130,
          child: BackgroundCircle(),
        ),
        child
      ],
    );
  }
}
