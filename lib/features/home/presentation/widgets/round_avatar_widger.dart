import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';

import '../../../profile/presentation/pages/my_profile_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class RoundAvatarWidget extends StatelessWidget {
  RoundAvatarWidget({required this.size,required this.userEntity,super.key});

  double size;
  UserEntity userEntity;

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
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFFFF5F5),
              Color(0xFFFFFFFF)],
          ),
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: userEntity.avatarUrl,
            fit: BoxFit.cover,
            placeholder: (context,st){
              return CupertinoActivityIndicator();
            },
            errorWidget: (context,obj,excp){
              return Icon(Icons.man,color: Colors.red,size: 40,);
            },

          ),
        ),
      ),
    );
  }
}
