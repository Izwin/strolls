import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_bloc.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_city_dropdown.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_gender_picker.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_gender_picker_with_any.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_number_picker.dart';
import 'package:strolls/features/home/domain/params/create_strolls_params.dart';
import 'package:strolls/features/home/presentation/bloc/strolls_bloc.dart';
import 'package:strolls/features/home/presentation/pages/main_page.dart';

import '../../../../core/utills/dialog_utils.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../auth/presentation/bloc/registration_state.dart';
import '../../../auth/presentation/widgets/gradient_date_and_time_picker.dart';
import '../../../auth/presentation/widgets/gradient_text_field.dart';
import '../widgets/background_with_circles.dart';
import '../widgets/glass_container.dart';
import '../widgets/white_button.dart';

class CreateStrollSecondPage extends StatefulWidget {
  CreateStrollSecondPage(
      {required this.dateTime,
      required this.title,
      required this.note,
      super.key});

  DateTime dateTime;
  String title;
  String note;

  @override
  State<CreateStrollSecondPage> createState() => _CreateStrollSecondPageState();
}

class _CreateStrollSecondPageState extends State<CreateStrollSecondPage> {
  int? age;
  String? language;
  String? gender;
  String? city;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StrollsBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BackgroundWithCircles(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(
                    title: 'Create',
                  ),
                  GlassContainer(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: GradientGenderPickerWithAny(
                                  label: "Gender",
                                  onSelectedItemChanged: (item) {
                                    gender = item;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: GradientNumberPicker(
                                  onNumberChanged: (num) => age = num,
                                  label: "Age",
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocProvider(
                          create: (context) =>
                              getIt<RegistrationBloc>()..add(GetCitiesEvent()),
                          child:
                              BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              if (state is GotCitiesState) {
                                return Center(
                                    child: GradientDropDown(
                                  label: "City",
                                  items: state.cities,
                                  onChanged: (city) {
                                    this.city = city;
                                  },
                                ));
                              } else if (state is RegistrationLoading) {
                                return Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              } else {
                                return Center(
                                  child: Text("Error"),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocProvider(
                          create: (context) => getIt<RegistrationBloc>()
                            ..add(GetLanguagesEvent()),
                          child:
                              BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              if (state is GotLanguagesState) {
                                return Center(
                                    child: GradientDropDown(
                                  label: "Language",
                                  items: state.languages,
                                  onChanged: (lang) {
                                    language = lang;
                                  },
                                ));
                              } else if (state is RegistrationLoading) {
                                return Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              } else {
                                return Center(
                                  child: Text("Error"),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
                  BlocConsumer<StrollsBloc, StrollsState>(
                    listener: (context,state){
                      if(state is StrollsErrorState){
                        DialogUtils.showDialog(context, state.message);
                      }
                      else if (state is StrollCreatedState){
                        Navigator.pushAndRemoveUntil(context,
                            CupertinoPageRoute(builder: (context) {
                              return MainPage();
                            }), (route) => false);
                      }
                    },
                    builder: (context, state) {
                      return WhiteButton(
                          text: "Create",
                          onTap: () {
                            _onContinuePressed(context);
                          });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onContinuePressed(BuildContext context) {
    if (_hasErrors()) {
      DialogUtils.showDialog(context, "Please, fill all fields");
    } else {
      var bloc = context.read<StrollsBloc>();
      bloc.add(CreateStrollsEvent(
          createStrollParams: CreateStrollParams(
              dateTime: widget.dateTime,
              title: widget.title,
              note: widget.note,
              age: age!,
              city: city!,
              language: language!,
              gender: gender!)));
    }
  }

  bool _hasErrors() {
    return age == null || gender == null || city == null || language == null;
  }
}
