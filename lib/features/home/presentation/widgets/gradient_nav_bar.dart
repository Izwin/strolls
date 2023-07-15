import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientNavBar extends StatefulWidget {
  GradientNavBar({required this.onItemSelected,Key? key}) : super(key: key);

  void Function(int index) onItemSelected;

  @override
  State<GradientNavBar> createState() => _GradientNavBarState();
}

class _GradientNavBarState extends State<GradientNavBar> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      notchMargin: 6,
      height: 70,
      padding: EdgeInsets.all(0),
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  Colors.black.withOpacity(0.4),
                  Color(0xFF260000).withOpacity(0.4)
                ]),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1E0000).withOpacity(0.6),
                    Color(0xFF000000).withOpacity(0.6),
                  ],
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _index,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Colors.transparent,
                iconSize: 30,
                selectedIconTheme: IconThemeData(size: 35),
                unselectedIconTheme: IconThemeData(size: 35),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withOpacity(0.6),
                onTap: (i) {
                  _index = i;
                  widget.onItemSelected.call(i);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: ""),
                ],
              ),
            ),
          )),
    );
  }
}
