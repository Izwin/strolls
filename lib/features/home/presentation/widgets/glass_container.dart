import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class GlassContainer extends StatelessWidget {
  GlassContainer({required this.child, this.height, this.width, this.gradient,Key? key}) : super(key: key);

  Widget child;
  double? width;
  double? height;
  Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: const GradientBoxBorder(
              width: 1,
              gradient: LinearGradient(colors: [
                Color(0x66FFFFFF),
                Color(0x66000000),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
          borderRadius: BorderRadius.circular(34)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            curve: Curves.ease,

            height: height,
            width: width,
            decoration: BoxDecoration(
                gradient: gradient ?? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFF0000).withOpacity(0.1),
                    const Color(0xFF4F1111).withOpacity(0.1),
                  ],
                ),),
            child: child,
          ),
        ),
      ),
    );
  }


}
