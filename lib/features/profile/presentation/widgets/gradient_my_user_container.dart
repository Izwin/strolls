import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/presentation/widgets/rouned_avatar.dart';

import '../../../home/presentation/widgets/glass_container.dart';
import '../../../home/presentation/widgets/key_value_title_white.dart';
import '../../../home/presentation/widgets/white_button.dart';
import '../bloc/friends/friends_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../pages/edit_profile_page.dart';

class GradientMyUserContainer extends StatelessWidget {
  const GradientMyUserContainer({required this.userEntity,super.key});
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Container(
                  child: Row(
                    children: [
                      RoundedAvatar(
                          url: userEntity.avatarUrl),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Spacer(
                              flex: 2,
                            ),
                            KeyValueTitleProfile(
                              title: "City",
                              value: userEntity.city,
                            ),
                            Spacer(),
                            KeyValueTitleProfile(
                                title: "Gender",
                                value: userEntity.gender),
                            Spacer(),
                            KeyValueTitleProfile(
                                title: "Age",
                                value: userEntity.age
                                    .toString()),
                            Spacer(),
                            KeyValueTitleProfile(
                                title: "Languages",
                                value: userEntity.languages
                                    .join(", ")),
                            Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                userEntity.bio,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    height: 1.2,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: WhiteButton(
                    text: "Edit",
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                            return EditProfilePage(
                              userEntity: userEntity,
                            );
                          })).then((value) {
                        _updateProfile(context);
                      });
                    },
                    height: 45,
                    fontSize: 25,
                  ))
            ],
          ),
        ));


  }
  void _updateProfile(BuildContext context) {
    context.read<ProfileBloc>().add(GetProfileEvent());
  }
}
