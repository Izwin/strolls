import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/key_value_title.dart';
import 'package:strolls/features/profile/presentation/widgets/vertical_key_value_title.dart';

import '../../../home/presentation/widgets/key_value_title_white.dart';
import '../../../home/presentation/widgets/stroll_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWithCircles(
        child: Padding(
          padding: EdgeInsets.only(top: 10, right: 20, left: 20),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(),
                  SizedBox(
                    height: 20,
                  ),
                  GlassContainer(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.yellow),
                                    child: Image.network(
                                      "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    KeyValueTitleProfile(
                                      title: "City",
                                      value: "Minsk",
                                    ),
                                    KeyValueTitleProfile(
                                        title: "Gender", value: "Male"),
                                    KeyValueTitleProfile(
                                        title: "Age", value: "18"),
                                    KeyValueTitleProfile(
                                        title: "Languages",
                                        value: "Russian,Azerbaijan"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VerticalKeyValueWidget(),
                            VerticalKeyValueWidget(),
                            VerticalKeyValueWidget(),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hello! My name is Lukas and i am a Dota 2 player. My favorite hero is Tinker and i have 83% winrate on him. Also i have 7000 mmr in Dota 2.",
                          style: TextStyle(color: Colors.white,fontSize: 16,height: 1.2,fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  )),
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("Last Strolls",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      ..._buildStrollList()
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 70,
          child: TitleText(title: "Lukas"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            "@goluboyokean",
            textAlign: TextAlign.center,
            style: TextStyle(

                color: Color(0xFFFFF3B7),
                height: 0.2,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
  List<Widget> _buildStrollList() {
    return [
      StrollItem(),
      const SizedBox(
        height: 20,
      ),
      StrollItem(),
      const SizedBox(
        height: 20,
      ),
      StrollItem(),
      const SizedBox(
        height: 20,
      ),
      StrollItem(),
      const SizedBox(
        height: 20,
      ),
      StrollItem(),
    ];
  }
}
