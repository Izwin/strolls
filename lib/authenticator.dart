import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:strolls/core/bloc/authenticator_bloc.dart';
import 'package:strolls/features/home/presentation/pages/home_page.dart';
import 'package:strolls/features/home/presentation/pages/intro_page.dart';
import 'package:strolls/features/home/presentation/pages/main_page.dart';
import 'package:strolls/features/home/presentation/widgets/background_circle.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';

import 'core/bloc/authenticator_state.dart';
import 'core/getit/get_it.dart';

class Authenticator extends StatelessWidget {
  Authenticator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticatorBloc, AuthenticatorState>(
      listener: (BuildContext context, state) {
        if (state is AuthorizedState) {
          print("NAVIGATE");
          navigate(child: MainPage());
        } else if (state is UnauthorizedState) {
          navigate(child: IntroPage());
        }
      },
      child: BackgroundWithCircles(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  void navigate({required Widget child}) {
    Get.to(child);
  }
}
