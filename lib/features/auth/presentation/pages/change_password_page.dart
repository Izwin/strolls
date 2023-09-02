import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/features/auth/presentation/pages/login_page.dart';
import 'package:strolls/features/auth/presentation/pages/register_page.dart';

import '../../../../core/bloc/authenticator_bloc.dart';
import '../../../../core/bloc/authenticator_event.dart';
import '../../../../core/bloc/authenticator_state.dart';
import '../../../../core/utills/dialog_utils.dart';
import '../../../../core/widgets/gradient_scaffold.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../home/presentation/widgets/glass_container.dart';
import '../../../home/presentation/widgets/white_button.dart';
import '../widgets/gradient_text_field.dart';
import 'forget_password_page.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({required this.token, required this.email, super.key});

  TextEditingController password = TextEditingController();
  String email, token;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticatorBloc, AuthenticatorState>(
      listener: (context, state) {
        if (state is ForgetPasswordError) {
          DialogUtils.showDialog(context, "Error");
        } else if (state is SuccessChangedPasswordState) {
          Navigator.push(
              context,
              CupertinoDialogRoute(
                  context: context,
                  builder: (context) {
                    return LoginPage();
                  }));
        }
      },
      child: GradientScaffold(
          child: Column(
        children: [
          Expanded(
            child: TitleText(
              title: "Change Password",
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
                                "Set new password",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          GradientTextField(
                            label: "New password",
                            controller: password,
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
                  child: WhiteButton(
                      text: "Continue",
                      onTap: () {
                        _onContinuePressed(context);
                      }))),
        ],
      )),
    );
  }

  void _onContinuePressed(BuildContext context) {
    context.read<AuthenticatorBloc>().add(ChangePasswordEvent(
        password: password.text, email: email, token: token));
  }
}
