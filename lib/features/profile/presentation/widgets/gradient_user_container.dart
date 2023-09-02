import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/presentation/widgets/rouned_avatar.dart';

import '../../../../core/getit/get_it.dart';
import '../../../home/presentation/widgets/glass_container.dart';
import '../../../home/presentation/widgets/key_value_title_white.dart';
import '../../../home/presentation/widgets/white_button.dart';
import '../../domain/entities/friendship_request_entity.dart';
import '../bloc/friends/friends_bloc.dart';
import '../bloc/profile/profile_bloc.dart';

class GradientUserContainer extends StatelessWidget {
  const GradientUserContainer({required this.userEntity,
    required this.myFriendshipRequests,
    required this.sentFriendshipRequests,
    super.key});

  final UserEntity userEntity;
  final List<FriendshipRequestEntity> myFriendshipRequests;
  final List<FriendshipRequestEntity> sentFriendshipRequests;

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
                      RoundedAvatar(url: userEntity.avatarUrl),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                title: "Gender", value: userEntity.gender),
                            Spacer(),
                            KeyValueTitleProfile(
                                title: "Age", value: userEntity.age.toString()),
                            Spacer(),
                            KeyValueTitleProfile(
                                title: "Languages",
                                value: userEntity.languages.join(", ")),
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
                  child: _buildProfileButton(context, userEntity))
            ],
          ),
        ));
  }

  Widget _buildProfileButton(BuildContext context, UserEntity userEntity) {
    return BlocProvider(
      create: (context) => getIt<FriendsBloc>(),
      child: BlocConsumer<FriendsBloc, FriendsState>(
          listener: (context, state) {
            if (state is ShouldUpdateState) {
              context.read<FriendsBloc>().add(GetFriendshipRequestEvent());
              context
                  .read<ProfileBloc>()
                  .add(GetProfileByIdEvent(id: userEntity.id));
            }
          },
          builder: (context, state) {
            var myUser = Get.find<UserEntity>();
            if (myFriendshipRequests
                .any((element) => element.senderId == userEntity.id)) {
              return WhiteButton(
                text: "Accept",
                onTap: () {
                  context
                      .read<FriendsBloc>()
                      .add(AcceptFriendRequestEvent(id: userEntity.id));
                },
                height: 45,
                fontSize: 25,
              );
            } else if (sentFriendshipRequests
                .any((element) => element.receiverId == userEntity.id)) {
              return WhiteButton(
                text: "Cancel",
                onTap: () {
                  context
                      .read<FriendsBloc>()
                      .add(CancelFriendRequestEvent(id: userEntity.id));
                },
                height: 45,
                fontSize: 25,
              );
            } else if (userEntity.friends
                .any((element) => element.id == myUser.id)) {
              return WhiteButton(
                text: "Delete friend",
                onTap: () {
                  context
                      .read<FriendsBloc>()
                      .add(DeleteFriendEvent(id: userEntity.id));
                },
                height: 45,
                fontSize: 25,
              );
            } else {
              return WhiteButton(
                text: "Friend Request",
                onTap: () {
                  context
                      .read<FriendsBloc>()
                      .add(SendFriendRequestEvent(id: userEntity.id));
                },
                height: 45,
                fontSize: 25,
              );
            }
          }),
    );
  }
}