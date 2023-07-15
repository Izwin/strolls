import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/key_value_title.dart';

class StrollItem extends StatelessWidget {
  StrollItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: 500,
      height: 145,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text(
                      "Aquapark",
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "23/03",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "19:00",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Aquapark near InHotel",
                  style: TextStyle(
                      height: 1.2,
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                KeyValueTitle(title: "Gender", value: "Any"),
                KeyValueTitle(title: "Age", value: "+18"),
                KeyValueTitle(title: "Language", value: "English"),
                KeyValueTitle(title: "City", value: "Minsk")
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                children: [
                  Container(
                    height: 45,
                    child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (i, c) {
                          return Center(
                            child: Transform.translate(
                              offset: Offset((3 - c) * 13, 0),
                              child: Container(
                                width: 45,
                                height: 45,
                                child: ClipOval(
                                  child: Image.network(
                                    links[c],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [Color(0xFFBFF8FF), Color(0xFF55CCFF)],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> links = [
    "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
    "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
    "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
  ];
}
