import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/utills/dialog_utils.dart';
import 'package:strolls/core/widgets/gradient_scaffold.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/auth/presentation/pages/forget_password_page.dart';
import 'package:strolls/features/auth/presentation/pages/register_page.dart';
import 'package:strolls/features/home/presentation/pages/home_page.dart';
import 'package:strolls/features/home/presentation/pages/main_page.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_text_field.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';

import '../../../../core/bloc/authenticator_bloc.dart';
import '../../../../core/bloc/authenticator_event.dart';
import '../../../../core/bloc/authenticator_state.dart';
import '../../../../core/getit/get_it.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController username = TextEditingController(),
      password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticatorBloc, AuthenticatorState>(
      listener: (context,state){
        if(state is AuthenticatorError){
          DialogUtils.showDialog(context, "Password or login error");
        }
      },
      builder: (context, state) {
        return GradientScaffold(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TitleText(title: "Sign in",),),
                    Expanded(
                      flex: 2,
                      child: GlassContainer(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 5),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            "Strolls",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 35,
                                                fontWeight:
                                                    FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  Alignment.topCenter,
                                              child: GradientTextField(
                                                label:
                                                    "Username or email",
                                                controller: username,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment
                                                  .bottomCenter,
                                              child: GradientTextField(
                                                label: "Password",
                                                maxLines: 1,
                                                controller: password,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(
                                      flex: 2,
                                    )
                                  ],
                                ),
                                Positioned(
                                  bottom: 25,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                  builder: (context) {
                                            return ForgetPasswordPage();
                                          }));
                                        },
                                        child: Text(
                                          "Forget Password",
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.7),
                                              fontSize: 16),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                  builder: (context) {
                                            return const RegisterPage();
                                          }));
                                        },
                                        child: Text(
                                          "I have not an account.",
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.7),
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: WhiteButton(
                                text: "Continue",
                                onTap: () {
                                  _onContinuePressed(context);
                                }))),
                  ],

        ));
      },
    );
  }


  void _onContinuePressed(BuildContext context){
    context.read<AuthenticatorBloc>().add(
        SendAuthEvent(
            username: username.text,
            password: password.text));
  }
}
