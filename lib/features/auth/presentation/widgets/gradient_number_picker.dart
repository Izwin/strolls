import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';

class GradientNumberPicker extends StatefulWidget {
  GradientNumberPicker(
      {required this.label,required this.onNumberChanged, Key? key})
      : super(key: key);
  String label;
  Function(int number) onNumberChanged;


  @override
  State<GradientNumberPicker> createState() => _GradientNumberPicker();
}

class _GradientNumberPicker extends State<GradientNumberPicker> {
  TextEditingController controller = TextEditingController();
  List<int> ages = List.generate(99, (index) => index).skip(12).toList();
  @override


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
                  child: CupertinoPicker(
                    itemExtent: 40,

                    onSelectedItemChanged: (int value) {
                      widget.onNumberChanged.call(ages[value]);
                      controller.text = "${ages[value]}+";
                    },
                    children: [
                      ...ages.map((e) => Text(e.toString(),style: TextStyle(fontSize: 30)))
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
