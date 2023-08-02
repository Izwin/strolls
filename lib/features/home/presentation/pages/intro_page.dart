import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/pages/main_page.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';

import '../../../auth/presentation/pages/login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWithCircles(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 35, right: 25, left: 25),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello!",
                  style: TextStyle(
                      color: Colors.white,
                      height: 1.2,
                      fontSize: 86,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Lets\nStart!\nIt will\nTakes\nAbout\n2 minutes.",
                  style: TextStyle(
                      color: Colors.white,
                      height: 1.2,
                      fontSize: 55,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                WhiteButton(
                    text: "Start",
                    onTap: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (context) {
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
