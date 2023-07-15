import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:strolls/features/home/presentation/pages/home_page.dart';
import 'package:strolls/features/home/presentation/pages/intro_page.dart';
import 'package:strolls/features/home/presentation/widgets/background_circle.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/gradient_nav_bar.dart';
import 'package:strolls/features/home/presentation/widgets/stroll_item.dart';

import 'features/home/presentation/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: IntroPage(),
    );
  }
}


