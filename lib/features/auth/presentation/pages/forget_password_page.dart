import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/bloc/authenticator_bloc.dart';
import 'package:strolls/core/bloc/authenticator_event.dart';
import 'package:strolls/core/utills/dialog_utils.dart';
import 'package:strolls/core/widgets/gradient_scaffold.dart';
import 'package:strolls/features/auth/presentation/pages/confirm_forget_password_page.dart';
import 'package:strolls/features/home/presentation/pages/main_page.dart';

import '../../../../core/bloc/authenticator_state.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../home/presentation/widgets/glass_container.dart';
import '../../../home/presentation/widgets/white_button.dart';
import '../widgets/gradient_text_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticatorBloc, AuthenticatorState>(
      listener: (context, state) {
        if(state is ForgetPasswordError){
          DialogUtils.showDialog(context, "Error");
        }
        else if(state is ForgetPasswordTokenSentState){
          Navigator.push(context, CupertinoDialogRoute(context: context, builder: (context){
            return ConfirmForgetPasswordPage(email: email.text.trim(),);
          }));
        }
      },
      child: GradientScaffold(
          child: Column(
            children: [
              Expanded(
                child: TitleText(
                  title: "Forget Password",
                ),
              ),
              Expanded(
                flex: 1,
                child: GlassContainer(
                  child: Center(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    "Enter email for password recovery",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              GradientTextField(
                                label: "Username or email",
                                controller: email,
                                height: 60,
                                maxLines: 1,
                              ),
                              Spacer()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: WhiteButton(text: "Continue", onTap: () {
                        _onContinuePressed(context);
                      }))),
            ],
          )),
    );
  }

  void _onContinuePressed(BuildContext context) {
    context
        .read<AuthenticatorBloc>()
        .add(ForgetPasswordEvent(email: email.text));
  }
}
