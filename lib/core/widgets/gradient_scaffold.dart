import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';

class GradientScaffold extends StatelessWidget {
  GradientScaffold({required this.child, super.key});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWithCircles(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }
}
