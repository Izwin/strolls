import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/presentation/pages/my_profile_page.dart';

import '../../../profile/presentation/pages/profile_page.dart';
import '../../../profile/presentation/widgets/rouned_avatar.dart';
import 'glass_container.dart';
import 'key_value_title_white.dart';

class MemberItemWidget extends StatelessWidget {
  MemberItemWidget({required this.userEntity,super.key});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        var myProfile = Get.find<UserEntity>();
        if(myProfile.id == userEntity.id){
          Navigator.push(context, CupertinoPageRoute(builder: (context){
            return MyProfilePage();
          }));
        }
        else{
          Navigator.push(context, CupertinoPageRoute(builder: (context){
            return ProfilePage(userId: userEntity.id,);
          }));
        }

      },
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedAvatar(
                url: userEntity.avatarUrl,
                size: 100,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Text(
                      userEntity.firstname,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                    Text(
                      "@${userEntity.username}",
                      style: TextStyle(
                          color: Color(0xFFFFF4B8),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    KeyValueTitleProfile(
                        title: "Age",
                        value: userEntity.age
                            .toString()),
                    KeyValueTitleProfile(
                        title: "Languages",
                        value: userEntity.languages
                            .join(", ")),
                    KeyValueTitleProfile(
                        title: "City",
                        value: userEntity.city),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
