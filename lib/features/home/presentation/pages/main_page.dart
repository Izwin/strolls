import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../profile/presentation/pages/my_profile_page.dart';
import '../widgets/gradient_nav_bar.dart';
import 'create_stroll_first_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _buildScreens().elementAt(_index),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) {
                  return const CreateStrollFirstPage();
                },
              ),
            );
          },
          child: const Text("+",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: Color(0xFF200A1C),
              )),
          backgroundColor: const Color(0xFFFFE3B8),
          shape: const CircleBorder(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: GradientNavBar(
        onItemSelected: (i) {
          setState(() {
            _index = i;
          });
        },
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      MyProfilePage(),
    ];
  }
}
