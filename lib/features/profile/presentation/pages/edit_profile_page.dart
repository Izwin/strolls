import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/core/utills/dialog_utils.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:strolls/features/profile/presentation/bloc/update_profile/update_profile_bloc.dart';
import 'package:strolls/features/profile/presentation/widgets/cities_selector_widget.dart';
import 'package:strolls/features/profile/presentation/widgets/languages_selector_widget.dart';
import 'package:strolls/features/profile/presentation/widgets/rouned_avatar.dart';

import '../../../auth/presentation/bloc/registration_bloc.dart';
import '../../../auth/presentation/bloc/registration_state.dart';
import '../../../auth/presentation/widgets/gradient_city_dropdown.dart';
import '../../../auth/presentation/widgets/gradient_text_field.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({required this.userEntity, super.key});

  UserEntity userEntity;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ImagePicker imagePicker = ImagePicker();
  List<String?> languages = [null];
  String city = "";
  XFile? file;
  var bioController = TextEditingController();

  @override
  void initState() {
    languages
      ..clear()
      ..addAll(widget.userEntity.languages);
    bioController.text = widget.userEntity.bio;
    city = widget.userEntity.city;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<UpdateProfileBloc>(),
        ),
        BlocProvider.value(
          value: getIt<ProfileBloc>(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BackgroundWithCircles(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          45 -
                          MediaQuery.of(context).viewPadding.top),
                  child: BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is GotProfileState) {
                        setState(() {
                          widget.userEntity = state.userEntity;
                        });
                      } else if (state is ProfileErrorState) {
                        DialogUtils.showDialog(context, state.message);
                      }
                    },
                    child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                      listener: (context, state) {
                        if (state is ImageUploadedState) {
                          updateProfileImage(context);
                        } else if (state is ProfileUpdatedState) {
                          Navigator.pop(context);
                        } else if (state is ProfileUpdateError) {
                          DialogUtils.showDialog(context, state.error);
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TitleText(title: "Edit"),
                            const SizedBox(
                              height: 40,
                            ),
                            GlassContainer(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildProfileAvatar(context),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    LanguagesSelectorWidget(
                                        languages: languages,
                                        onChanged: (l) => languages = l),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CitiesSelectorWidget(
                                        city: city, onChanged: (c) => city = c),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GradientTextField(
                                      height: null,
                                      minLines: 3,
                                      maxLines: 8,
                                      label: "About me",
                                      controller: bioController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                              builder: (context, state) {
                                return WhiteButton(
                                    text: "Continue",
                                    onTap: () {
                                      sendUpdateProfileEvent(context);
                                    });
                              },
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendUpdateProfileEvent(BuildContext context) {
    var bloc = context.read<UpdateProfileBloc>();
    languages.removeWhere((element) => element == null);

    bloc.add(SendUpdateProfileEvent(
        languages: languages.map((e) => e!).toList(),
        bio: bioController.text,
        city: city));
  }

  void updateProfileImage(BuildContext context) {
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  Widget _buildProfileAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
          if (value != null) {
            var bloc = context.read<UpdateProfileBloc>();
            bloc.add(UploadImageEvent(file: value));
          }
        });
      },
      child: RoundedAvatar(url: widget.userEntity.avatarUrl),
    );
  }
}
