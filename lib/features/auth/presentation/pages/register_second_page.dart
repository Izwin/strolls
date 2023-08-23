import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_bloc.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_language_selector.dart';
import 'package:strolls/features/profile/presentation/widgets/languages_selector_widget.dart';

import '../../../home/presentation/widgets/glass_container.dart';
import '../bloc/registration_state.dart';
import '../widgets/gradient_city_dropdown.dart';
import '../widgets/gradient_text_field.dart';

class RegisterSecondPage extends StatefulWidget {
  RegisterSecondPage(
      {required this.bioController,
      required this.languages,
      required this.onLanguageChanged,
      super.key});

  List<String?> languages;
  TextEditingController bioController;
  Function(List<String?>) onLanguageChanged;


  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegistrationBloc>()..add(GetLanguagesEvent()),
      child: GlassContainer(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            LanguagesSelectorWidget(languages: widget.languages,onChanged: widget.onLanguageChanged,),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GradientTextField(
                height: null,
                minLines: 3,
                maxLines: 8,
                label: "About me",
                controller: widget.bioController,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
