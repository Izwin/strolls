import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:jiffy/jiffy.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/home/presentation/pages/stroll_info_creator_page.dart';
import 'package:strolls/features/home/presentation/pages/stroll_info_member_page.dart';
import 'package:strolls/features/home/presentation/pages/stroll_info_page.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/key_value_title.dart';
import 'package:strolls/features/home/presentation/widgets/round_avatar_widger.dart';

class StrollItem extends StatelessWidget {
  StrollItem({required this.profileId, required this.strollEntity, Key? key})
      : super(key: key);
  final StrollEntity strollEntity;
  final int profileId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(strollEntity.members.any((element) => element.id == profileId)){
          if(strollEntity.creator.id == profileId){
            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return StrollInfoCreatorPage(strollId: strollEntity.id);
            }));
          }
          else{
            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return StrollInfoMemberPage(strollId: strollEntity.id);
            }));
          }
        }
        else{
          Navigator.push(context, CupertinoPageRoute(builder: (context) {
            return StrollInfoPage(strollId: strollEntity.id);
          }));
        }

      },
      child: GlassContainer(
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
                        strollEntity.title,
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
                        Jiffy.parseFromDateTime(strollEntity.date!.toLocal())
                            .format(pattern: "dd/MM"),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        Jiffy.parseFromDateTime(strollEntity.date.toLocal())
                            .format(pattern: "hh:mm"),
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
                    "${strollEntity.description}",
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  KeyValueTitle(
                      title: "Gender",
                      value: "${strollEntity.gender.capitalizeFirst}"),
                  KeyValueTitle(
                      title: "Age", value: "${strollEntity.minimumAge}+"),
                  KeyValueTitle(
                      title: "Language", value: "${strollEntity.language}"),
                  KeyValueTitle(title: "City", value: "${strollEntity.city}")
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
                          itemCount: strollEntity.members.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (i, c) {
                            return Center(
                              child: Transform.translate(
                                offset: Offset(
                                    (strollEntity.members.length - c) * 13, 0),
                                child: RoundAvatarWidget(userEntity: strollEntity.members[c],size: 45,),
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
      ),
    );
  }

  List<String> links = [
    "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
    "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
    "https://www.drivetest.de/wp-content/uploads/2019/08/drivetest-avatar-m.png",
  ];
}
