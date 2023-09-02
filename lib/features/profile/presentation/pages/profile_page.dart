import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:strolls/core/widgets/gradient_scaffold.dart';
import 'package:strolls/features/profile/data/models/user_model.dart';
import 'package:strolls/features/profile/presentation/bloc/friends/friends_bloc.dart';
import 'package:strolls/features/profile/presentation/widgets/gradient_user_container.dart';

import '../../../../core/bloc/authenticator_bloc.dart';
import '../../../../core/getit/get_it.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../home/domain/entities/stroll_entity.dart';
import '../../../home/presentation/bloc/strolls_bloc.dart';
import '../../../home/presentation/widgets/background_with_circles.dart';
import '../../../home/presentation/widgets/glass_container.dart';
import '../../../home/presentation/widgets/key_value_title_white.dart';
import '../../../home/presentation/widgets/stroll_item.dart';
import '../../../home/presentation/widgets/white_button.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/profile/profile_bloc.dart';
import '../widgets/rouned_avatar.dart';
import '../widgets/vertical_key_value_title.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({required this.userId, super.key});

  int userId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<ProfileBloc>()..add(GetProfileByIdDataEvent(id: userId)),
        ),
      ],
      child: GradientScaffold(
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              else if (state is GotProfileDataState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppBar(state.userEntity),
                    const SizedBox(
                      height: 20,
                    ),
                    GradientUserContainer(
                      userEntity: state.userEntity,
                      myFriendshipRequests: state.myRequests,
                      sentFriendshipRequests: state.sentRequests,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Strolls",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          _getStrolls(state.strolls)
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Center();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(UserEntity userEntity) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                child: TitleText(title: userEntity.firstname),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "@${userEntity.username}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xFFFFF3B7),
                      height: 0.2,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          );
  }

  Widget _getStrolls(List<StrollEntity> strolls) {
        var userEntity = Get.find<UserEntity>();
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  StrollItem(
                    strollEntity: strolls[index],
                    profileId: userEntity!.id,
                  ),
                ],
              );
            },
            itemCount: strolls.length,
            shrinkWrap: true,
          );
  }
}
