import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/features/auth/presentation/pages/change_password_page.dart';

import '../../../../core/bloc/authenticator_bloc.dart';
import '../../../../core/bloc/authenticator_event.dart';
import '../../../../core/bloc/authenticator_state.dart';
import '../../../../core/utills/dialog_utils.dart';
import '../../../../core/widgets/gradient_scaffold.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../home/presentation/widgets/glass_container.dart';
import '../../../home/presentation/widgets/white_button.dart';
import '../widgets/gradient_text_field.dart';
import 'login_page.dart';

class ConfirmForgetPasswordPage extends StatelessWidget {
  ConfirmForgetPasswordPage({required this.email,super.key});

  final String email;
  TextEditingController token = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticatorBloc, AuthenticatorState>(
      listener: (context, state) {
        if(state is ForgetPasswordError){
          DialogUtils.showDialog(context, "Error");
        }
        else if(state is SuccessConfirmForgetPasswordState){
          Navigator.push(context, CupertinoDialogRoute(context: context, builder: (context){
            return ChangePasswordPage(email: email,token: token.text,);
          }));
        }
      },
      child: GradientScaffold(
          child: Column(
            children: [
              Expanded(
                child: TitleText(
                  title: "Enter code",
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
                                    "Enter code from email!",
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
                                controller: token,
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
        .add(ConfirmForgetPasswordEvent(email: email,token: token.text));
  }
}
