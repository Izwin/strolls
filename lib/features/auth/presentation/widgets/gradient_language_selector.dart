import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/registration_bloc.dart';
import '../bloc/registration_state.dart';
import 'gradient_city_dropdown.dart';

class GradientLanguageSelector extends StatefulWidget {
  GradientLanguageSelector({required this.languages,required this.onLanguageChanged,super.key});

  List<String?> languages;
  Function(String,int) onLanguageChanged;
  @override
  State<GradientLanguageSelector> createState() => _GradientLanguageSelectorState();
}

class _GradientLanguageSelectorState extends State<GradientLanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        if(state is GotLanguagesState){
          return ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GradientDropDown(
                          label: "Language",
                          item: widget.languages[index],
                          items: state.languages,
                          onChanged: (language) {
                            widget.onLanguageChanged(language, index);
                          },

                  ),
                  const SizedBox(
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
            physics: const NeverScrollableScrollPhysics(),
          );

        }
        return Center(child: CupertinoActivityIndicator(),);
      },
    );
  }
}
