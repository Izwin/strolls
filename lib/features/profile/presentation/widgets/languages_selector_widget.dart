import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';

import '../../../../core/getit/get_it.dart';
import '../../../auth/presentation/bloc/registration_bloc.dart';
import '../../../auth/presentation/bloc/registration_state.dart';
import '../../../auth/presentation/widgets/gradient_city_dropdown.dart';

class LanguagesSelectorWidget extends StatefulWidget {
  LanguagesSelectorWidget({required this.languages,required this.onChanged, super.key});

  List<String?> languages;

  Function(List<String?>) onChanged;

  @override
  State<LanguagesSelectorWidget> createState() =>
      _LanguagesSelectorWidgetState();
}

class _LanguagesSelectorWidgetState extends State<LanguagesSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegistrationBloc>()..add(GetLanguagesEvent()),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  if (state is RegistrationLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else if (state is GotLanguagesState) {
                    return GradientDropDown(
                      label: "Language",
                      item: widget.languages[index],
                      items: state.languages,
                      onChanged: (language) {
                        widget.languages[index] = language;
                        widget.onChanged.call(widget.languages);
                      },
                    );
                  }
                  return const Center(
                    child: Text("Error"),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: index == widget.languages.length - 1 && index > 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.languages.removeAt(index);
                        });
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        size: 40,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Visibility(
                    visible: index == widget.languages.length - 1,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.languages.add(null);
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle_sharp,
                        size: 40,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          );
        },
        itemCount: widget.languages.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
