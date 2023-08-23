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
          create: (context) => getIt<ProfileBloc>()
            ..add(GetProfileEvent())
            ..add(GetProfileByIdEvent(id: userId)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<FriendsBloc>()..add(GetFriendshipRequestEvent()),
        ),
      ],
      child: GradientScaffold(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is GotProfileState) {
                      return GradientUserContainer(
                        userEntity: state.userEntity,
                      );
                    } else if (state is ProfileLoadingState) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (state is ProfileErrorState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return const Center();
                  },
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
                      _getStrolls()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is GotProfileState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                child: TitleText(title: state.userEntity.firstname),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  "@${state.userEntity.username}",
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
        return const Center();
      },
    );
  }

  Widget _getStrolls() {
    return BlocProvider(
      create: (context) =>
          getIt<StrollsBloc>()..add(GetStrollsByIdEvent(id: userId)),
      child: BlocBuilder<StrollsBloc, StrollsState>(
        builder: (context, state) {
          print(getIt<AuthenticatorBloc>().state.runtimeType);
          var userEntity = Get.find<UserEntity>();
          if (state is GotStrollsState) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    StrollItem(
                      strollEntity: state.strolls[index],
                      profileId: userEntity!.id,
                    ),
                  ],
                );
              },
              itemCount: state.strolls.length,
              shrinkWrap: true,
            );
          } else {
            return Center(
              child: Text(state.runtimeType.toString()),
            );
          }
        },
      ),
    );
  }
}
