import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:strolls/authenticator.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/core/widgets/gradient_scaffold.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/key_value_title.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:strolls/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:strolls/features/profile/presentation/widgets/gradient_my_user_container.dart';
import 'package:strolls/features/profile/presentation/widgets/rouned_avatar.dart';
import 'package:strolls/features/profile/presentation/widgets/vertical_key_value_title.dart';

import '../../../../core/bloc/authenticator_bloc.dart';
import '../../../home/presentation/widgets/key_value_title_white.dart';
import '../../../home/presentation/widgets/stroll_item.dart';

class MyProfilePage extends StatelessWidget {
  MyProfilePage({Key? key}) : super(key: key);

  List<Type> buildWhenForProfile = [
    GotProfileState,
    ProfileLoadingState,
    ProfileErrorState
  ];

  List<Type> buildWhenForStrolls = [
    GotProfileStrollsState,
    ProfileStrollsLoadingState,
    ProfileErrorState
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()
        ..add(GetProfileEvent())
        ..add(GetProfileStrollsEvent()),
      child: GradientScaffold(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (p, s) =>
                      buildWhenForProfile.contains(s.runtimeType),
                  builder: (context, state) {
                    if (state is GotProfileState) {
                      return GradientMyUserContainer(userEntity: state.userEntity);
                    } else if (state is ProfileLoadingState) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (state is ProfileErrorState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return Center();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
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
      buildWhen: (p, s) => buildWhenForProfile.contains(s.runtimeType),
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return Center(
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
        return Center();
      },
    );
  }

  Widget _getStrolls() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (p, s) => buildWhenForStrolls.contains(s.runtimeType),
      builder: (context, state) {
        var userEntity = Get.find<UserEntity>();
        if (state is GotProfileStrollsState) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
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
        ;
      },
    );
  }


}
