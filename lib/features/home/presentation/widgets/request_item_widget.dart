import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';

import '../../../profile/presentation/pages/my_profile_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../profile/presentation/widgets/rouned_avatar.dart';
import 'glass_container.dart';

class RequestItemWidget extends StatelessWidget {
  RequestItemWidget({required this.userEntity,required this.onAccept,required this.onDecline, super.key});

  final UserEntity userEntity;

  Function(UserEntity) onAccept;
  Function(UserEntity) onDecline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedAvatar(
                url: userEntity.avatarUrl,
                size: 70,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userEntity.firstname,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      "@${userEntity.username}",
                      style: TextStyle(
                          color: Color(0xFFFFF4B8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            onAccept.call(userEntity);
                          },
                          splashColor: Colors.red,
                          highlightColor: Colors.red,
                          child: Container(
                            child: Text(
                              "Accept",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            onDecline.call(userEntity);
                          },
                          child: Container(
                            child: Text(
                              "Decline",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.15)),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                          ),
                        ),
                      ],
                    )
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
