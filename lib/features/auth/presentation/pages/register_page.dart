import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/bloc/authenticator_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/features/auth/domain/entities/city_entity.dart';
import 'package:strolls/features/auth/domain/use_cases/get_cities_use_case.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_bloc.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';
import 'package:strolls/features/auth/presentation/pages/register_first_page.dart';
import 'package:strolls/features/auth/presentation/pages/register_second_page.dart';
import 'package:strolls/features/auth/presentation/pages/register_third_page.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_city_dropdown.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_date_picker.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_gender_picker.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_text_field.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';
import 'package:strolls/features/profile/domain/use_cases/get_users_use_case.dart';

import '../../data/models/send_registration_params_model.dart';
import '../bloc/registration_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentPage = 0;

  // Languages to send
  List<String?> languages = [null];

  List<String> titleList = ["First", "Second", "Third"];

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  String? gender;
  String? city;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<RegistrationBloc>()
            ..add(GetCitiesEvent())
            ..add(GetLanguagesEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<AuthenticatorBloc>(),
        ),
      ],
      child: BlocBuilder<AuthenticatorBloc, AuthenticatorState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: BackgroundWithCircles(
              child: GestureDetector(
                  onHorizontalDragEnd: (dragDetail) {
                    if (dragDetail.velocity.pixelsPerSecond.dx < 1) {
                    } else {
                      if (currentPage > 0) {
                        setState(() {
                          currentPage--;
                        });
                      }
                    }
                  },
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 25, right: 20, left: 20),
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
                              Text(
                                titleList[currentPage],
                                style: TextStyle(
                                    color: Colors.white,
                                    height: 1.2,
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 90,
                              ),
                              getPages(),
                              SizedBox(
                                height: 90,
                              ),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: WhiteButton(
                                    text: "Continue",
                                    onTap: () {
                                      onContinuePressed(context);
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget getPages() {
    var pages = [
      RegisterFirstPage(
          firstnameController: firstnameController,
          lastnameController: lastnameController,
          city: city,
          gender: gender,
          dateTime: date,
          onCityChanged: (city) {
            this.city = city;
          },
          onDateChanged: (date) {
            this.date = date;
          },
          onGenderChanged: (gender) {
            this.gender = gender;
          }),
      RegisterSecondPage(
        languages: languages,
        bioController: bioController,
        onLanguageChanged: (string, int) {
          languages[int] = string;
        },
      ),
      RegisterThirdPage(
          passwordController: passwordController,
          usernameController: usernameController,
          emailController: emailController),
    ];
    return pages[currentPage];
  }

  bool hasErrors() {
    switch (currentPage) {
      case 0:
        return firstnameController.text.isEmpty ||
            lastnameController.text.isEmpty ||
            gender == null ||
            city == null ||
            date == null;
      case 1:
        return languages.isEmpty ||
            languages[0] == null ||
            bioController.text.isEmpty;
      case 2:
        return usernameController.text.isEmpty ||
            passwordController.text.isEmpty ||
            emailController.text.isEmpty;
    }
    return false;
  }

  void showErrorsDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Fill all fields"),
            actions: [
              CupertinoDialogAction(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onContinuePressed(BuildContext context) {
    var authenticatorBloc = context.read<AuthenticatorBloc>();
    if (hasErrors()) {
      showErrorsDialog(context);
      return;
    }
    if (currentPage < 2) {
      setState(() {
        currentPage++;
      });
    } else {
      authenticatorBloc.add(
        SendRegistrationEvent(
            params: SendRegistrationParamsModel(
                city: city!,
                firstname: firstnameController.text,
                email: emailController.text,
                languages: languages.map((e) => e!).toList(),
                lastname: lastnameController.text,
                bio: bioController.text,
                dateOfBirth: date!,
                username: usernameController.text,
                password: passwordController.text)),
      );
    }
  }
}