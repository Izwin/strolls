import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/profile/presentation/pages/profile_page.dart';

import '../widgets/gradient_nav_bar.dart';
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
      floatingActionButton: Container(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          splashColor: Colors.transparent,
          onPressed: () {},
          child: Text("+",textAlign: TextAlign.center,style: TextStyle(fontSize: 40,fontWeight:FontWeight.w400,color: Color(0xFF200A1C),)),
          backgroundColor: Color(0xFFFFE3B8),
          shape: CircleBorder(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: GradientNavBar(onItemSelected: (i){
        setState(() {
          _index = i;
        });
      },),
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      ProfilePage(),
    ];
  }
}