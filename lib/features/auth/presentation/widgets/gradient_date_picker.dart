import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';

class GradientDatePicker extends StatefulWidget {
  GradientDatePicker(
      {required this.label,
      required this.onDateChanged,
      this.dateTime,
      Key? key})
      : super(key: key);
  String label;
  String? item;
  DateTime? dateTime;
  Function(DateTime) onDateChanged;

  @override
  State<GradientDatePicker> createState() => _GradientDatePickerState();
}

class _GradientDatePickerState extends State<GradientDatePicker> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.dateTime != null) {
      controller.text = Jiffy.parseFromDateTime(widget.dateTime!)
          .format(pattern: "dd/MM//yyyy");
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
                  height: 140,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        widget.onDateChanged.call(value);
                        controller.text = Jiffy.parseFromDateTime(value!)
                            .format(pattern: "dd/MM//yyyy");
                      });
                    },
                    mode: CupertinoDatePickerMode.date,
                  ),
                );
              });
        },
        expands: true,
        maxLines: null,
        minLines: null,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(color: Colors.white, fontSize: 14, height: 1),
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
