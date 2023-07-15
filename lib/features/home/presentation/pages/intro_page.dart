import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/pages/main_page.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';

import 'login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWithCircles(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,bottom: 35,right: 25,left: 25),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello!",
                  style: TextStyle(
                      color: Colors.white,
                      height: 1.2,
                      fontSize: 86,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Lets\nStart!\nIt will\nTakes\nAbout\n2 minutes.",
                  style: TextStyle(
                      color: Colors.white,
                      height: 1.2,
                      fontSize: 55,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                WhiteButton(text: "Start", onTap: (){
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
