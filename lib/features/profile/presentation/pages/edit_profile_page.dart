import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/presentation/bloc/update_profile/update_profile_bloc.dart';
import 'package:strolls/features/profile/presentation/widgets/rouned_avatar.dart';

import '../../../auth/presentation/bloc/registration_bloc.dart';
import '../../../auth/presentation/bloc/registration_state.dart';
import '../../../auth/presentation/widgets/gradient_city_dropdown.dart';
import '../../../auth/presentation/widgets/gradient_text_field.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({required this.userEntity, super.key});

  final UserEntity userEntity;

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
          create: (context) =>
              getIt<RegistrationBloc>()..add(GetLanguagesEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<UpdateProfileBloc>(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TitleText(title: "Edit"),
                      const SizedBox(
                        height: 40,
                      ),
                      BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                        listener: (context, state) {
                          if (state is ProfileUpdatedState) {
                            Navigator.pop(context);
                          }
                          if(state is ImageUploadedState){
                          }
                        },
                        builder: (context, state) {
                          return GlassContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await imagePicker.pickImage(
                                          source: ImageSource.gallery).then((value) {
                                            if(value!=null){
                                              var bloc = context.read<UpdateProfileBloc>();
                                              bloc.add(UploadImageEvent(file: value));
                                            }
                                      });
                                    },
                                    child: RoundedAvatar(
                                        url: widget.userEntity.avatarUrl),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ListView.builder(
                                    padding: const EdgeInsets.only(top: 20),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          BlocBuilder<RegistrationBloc,
                                              RegistrationState>(
                                            builder: (context, state) {
                                              if (state
                                                  is RegistrationLoading) {
                                                return const Center(
                                                  child:
                                                      CupertinoActivityIndicator(),
                                                );
                                              } else if (state
                                                  is GotLanguagesState) {
                                                return GradientDropDown(
                                                  label: "Language",
                                                  item: languages[index],
                                                  items: state.languages,
                                                  onChanged: (language) {
                                                    languages[index] = language;
                                                  },
                                                );
                                              }
                                              return const Center(
                                                child: Text("Error"),
                                              );
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Visibility(
                                                visible: index ==
                                                        languages.length - 1 &&
                                                    index > 0,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      languages.removeAt(index);
                                                    });
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_circle,
                                                    size: 40,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Visibility(
                                                visible: index ==
                                                    languages.length - 1,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      languages.add(null);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.add_circle_sharp,
                                                    size: 40,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                    itemCount: languages.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BlocProvider(
                                    create: (context) =>
                                        getIt<RegistrationBloc>()
                                          ..add(GetCitiesEvent()),
                                    child: BlocBuilder<RegistrationBloc,
                                        RegistrationState>(
                                      builder: (context, state) {
                                        if (state is GotCitiesState) {
                                          return Center(
                                              child: GradientDropDown(
                                            label: "City",
                                            item: widget.userEntity.city,
                                            items: state.cities,
                                            onChanged: (city) {
                                              city = city;
                                            },
                                          ));
                                        } else if (state
                                            is RegistrationLoading) {
                                          return const Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        } else {
                                          return const Center(
                                            child: Text("Error"),
                                          );
                                        }
                                      },
                                    ),
                                  ),
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
                          );
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                        builder: (context, state) {
                          return WhiteButton(
                              text: "Continue",
                              onTap: () {
                                updateProfile(context);
                              });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateProfile(BuildContext context) {
    var bloc = context.read<UpdateProfileBloc>();
    languages.removeWhere((element) => element == null);

    bloc.add(SendUpdateProfileEvent(
        languages: languages.map((e) => e!).toList(),
        bio: bioController.text,
        city: city));
  }
}
