import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'background_circle.dart';

class BackgroundWithCircles extends StatelessWidget {
  BackgroundWithCircles({Key? key,required this.child}) : super(key: key);
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Color(0xFF15010A)])
          ),
        ),
        Positioned(
          bottom: 50,
          left: -130,
          child: BackgroundCircle(height: 300,width: 300,),
        ),

        Positioned(
          top: 110,
          right: -130,
          child: BackgroundCircle(height: 300,width: 300,),
        ),
        child,

      ],
    );
  }
}
