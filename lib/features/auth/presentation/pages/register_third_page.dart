import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/bloc/authenticator_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/core/utills/dialog_utils.dart';
import 'package:strolls/features/profile/domain/use_cases/get_users_use_case.dart';

import '../../../home/presentation/widgets/glass_container.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_state.dart';
import '../widgets/gradient_text_field.dart';

class RegisterThirdPage extends StatelessWidget {
  RegisterThirdPage(
      {required this.passwordController, required this.usernameController, required this.emailController, super.key});

  TextEditingController usernameController, passwordController, emailController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticatorBloc, AuthenticatorState>(
      listener: (context, state) {
          if(state is AuthenticatorError){
            showDialog(context, state.errorMessage);
          }
        },
      child: GlassContainer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocConsumer<RegistrationBloc, RegistrationState>(
              listener: (context, state) {
                if (state is RegistrationError) {
                  showDialog(context, "Error");
                }
              },
              builder: (context, state) {
                if (state is RegistrationLoading) {
                  return const Center(child: CupertinoActivityIndicator(),);
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GradientTextField(
                          label: "Email", maxLines:1,controller: emailController),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GradientTextField(
                          label: "Username", maxLines: 1, controller: usernameController),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GradientTextField(
                          label: "Password", maxLines: 1, controller: passwordController),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }

  void showDialog(BuildContext context, String title) {
    DialogUtils.showDialog(context, title);
  }
}
