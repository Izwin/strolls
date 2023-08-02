import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/key_value_title.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';
import 'package:strolls/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:strolls/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:strolls/features/profile/presentation/widgets/rouned_avatar.dart';
import 'package:strolls/features/profile/presentation/widgets/vertical_key_value_title.dart';

import '../../../home/presentation/widgets/key_value_title_white.dart';
import '../../../home/presentation/widgets/stroll_item.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

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
      child: Scaffold(
        body: BackgroundWithCircles(
          child: Padding(
            padding: EdgeInsets.only(top: 10, right: 20, left: 20),
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
                                        RoundedAvatar(url: state.userEntity.avatarUrl),
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
                                                value: state.userEntity.city,
                                              ),
                                              Spacer(),
                                              KeyValueTitleProfile(
                                                  title: "Gender",
                                                  value:
                                                      state.userEntity.gender),
                                              Spacer(),
                                              KeyValueTitleProfile(
                                                  title: "Age",
                                                  value: state.userEntity.age
                                                      .toString()),
                                              Spacer(),
                                              KeyValueTitleProfile(
                                                  title: "Languages",
                                                  value: state
                                                      .userEntity.languages
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
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    VerticalKeyValueWidget(),
                                    VerticalKeyValueWidget(),
                                    VerticalKeyValueWidget(),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  state.userEntity.bio,
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
                                            CupertinoPageRoute(
                                                builder: (context) {
                                          return EditProfilePage(userEntity: state.userEntity,);
                                        }));
                                      },
                                      height: 45,
                                      fontSize: 25,
                                    ))
                              ],
                            ),
                          ));
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
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Last Strolls",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        _getStrolls()
                      ],
                    ),
                  ],
                ),
              ),
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
        if (state is GotProfileStrollsState) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  StrollItem(strollEntity: state.strolls[index]),
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
