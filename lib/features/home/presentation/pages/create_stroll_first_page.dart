import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/core/utills/dialog_utils.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/home/presentation/pages/create_stroll_second_page.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';

import '../../../auth/presentation/widgets/gradient_date_and_time_picker.dart';
import '../../../auth/presentation/widgets/gradient_date_picker.dart';
import '../../../auth/presentation/widgets/gradient_gender_picker.dart';
import '../../../auth/presentation/widgets/gradient_text_field.dart';
import '../widgets/glass_container.dart';

class CreateStrollFirstPage extends StatefulWidget {
  const CreateStrollFirstPage({super.key});

  @override
  State<CreateStrollFirstPage> createState() => _CreateStrollFirstPageState();
}

class _CreateStrollFirstPageState extends State<CreateStrollFirstPage> {
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWithCircles(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  title: 'Create',
                ),
                GlassContainer(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: GradientTextField(
                            label: "Title",
                            controller: titleController),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: GradientDateAndTimePicker(
                        label: "Date of birth",
                        onDateChanged: (d) => dateTime = d,
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GradientTextField(
                            label: "Note", controller: noteController),
                      ),
                    ],
                  ),
                )),
                WhiteButton(
                    text: "Continue",
                    onTap: () {
                      _onContinuePressed();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onContinuePressed() {
    if (_hasErrors()) {
      DialogUtils.showDialog(context, "Please, fill all fields");
    } else {
      Navigator.push(context, CupertinoPageRoute(builder: (context){
        return CreateStrollSecondPage(title: titleController.text,note: noteController.text,dateTime: dateTime!,);
      }));
    }
  }

  bool _hasErrors() {
    return noteController.text.isEmpty ||
        dateTime == null ||
        titleController.text.isEmpty;
  }
}
