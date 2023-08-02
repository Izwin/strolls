import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/bloc/authenticator_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
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
    return BlocProvider.value(value: getIt<AuthenticatorBloc>(),
      child: BlocListener<AuthenticatorBloc, AuthenticatorState>(
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
                  else if (state is RegistrationSuccess) {
                    showDialog(context, "Success");
                  }
                },
                builder: (context, state) {
                  if (state is RegistrationLoading) {
                    return Center(child: CupertinoActivityIndicator(),);
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GradientTextField(
                            label: "Email", controller: emailController),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GradientTextField(
                            label: "Username", controller: usernameController),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GradientTextField(
                            label: "Password", controller: passwordController),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }

  void showDialog(BuildContext context, String title) {
    showCupertinoDialog(context: context, builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        actions: [CupertinoDialogAction(child: Text("Ok"), onPressed: () {
          Navigator.pop(context);
        },)
        ],
      );
    });
  }
}
