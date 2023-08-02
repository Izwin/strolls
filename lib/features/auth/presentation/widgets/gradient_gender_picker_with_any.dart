import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';

class GradientGenderPickerWithAny extends StatefulWidget {
  GradientGenderPickerWithAny(
      {required this.label,
      this.gender,
      required this.onSelectedItemChanged,
      Key? key})
      : super(key: key);
  String label;
  String? gender;
  Function(String) onSelectedItemChanged;

  @override
  State<GradientGenderPickerWithAny> createState() =>
      _GradientDatePickerWithAnyState();
}

class _GradientDatePickerWithAnyState
    extends State<GradientGenderPickerWithAny> {
  List<String> stringList = ["Male", "Female", "Any"];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.gender != null) {
      controller.text = widget.gender!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 60,
      gradient: LinearGradient(
        begin: const Alignment(0.00, -1.00),
        end: const Alignment(0, 1),
        colors: [
          Colors.black.withOpacity(0.5),
          const Color(0xFF050005).withOpacity(0.5)
        ],
      ),
      child: TextField(
        readOnly: true,
        onTap: () {
          showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Container(
                  color: Colors.white,
                  height: 100,
                  child: CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        controller.text = stringList[value];
                        widget.onSelectedItemChanged.call(stringList[value]);
                      });
                    },
                    children: [
                      ...stringList.map(
                        (e) => Center(
                            child: Text(
                          e,
                          style: TextStyle(fontSize: 30),
                        )),
                      )
                    ],
                  ),
                );
              });
        },
        expands: true,
        maxLines: null,
        minLines: null,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(color: Colors.white, fontSize: 16, height: 1),
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          filled: true,
          hintText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35),
        ),
      ),
    );
  }
}
