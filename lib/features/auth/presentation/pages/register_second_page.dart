import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_bloc.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';

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
  Function(String, int) onLanguageChanged;


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
            ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocBuilder<RegistrationBloc, RegistrationState>(
                      builder: (context, state) {
                        if (state is RegistrationLoading) {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        } else if (state is GotLanguagesState) {
                          return GradientDropDown(
                            label: "Language",
                            item: widget.languages[index],
                            items: state.languages,
                            onChanged: (language) {
                              widget.onLanguageChanged(language, index);
                            },
                          );
                        }
                        return Center(
                          child: Text("Error"),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible:
                              index == widget.languages.length - 1 && index > 0,
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
                              setState(() {});
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
              physics: NeverScrollableScrollPhysics(),
            ),
            SizedBox(
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
