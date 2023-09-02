import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';

class GradientTextField extends StatelessWidget {
  GradientTextField({this.label, this.height = 60,this.maxLines,this.minLines,required this.controller,Key? key}) : super(key: key);
  String? label;
  TextEditingController controller;
  double? height;
  int? minLines;
  int? maxLines;
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: height,
      gradient: LinearGradient(
        begin: const Alignment(0.00, -1.00),
        end: const Alignment(0, 1),
        colors: [Colors.black.withOpacity(0.5), const Color(0xFF050005).withOpacity(0.5)],
      ),
      child: Center(
        child: TextField(
          minLines: minLines,
          maxLines: maxLines,
          expands: maxLines == null ? true : false,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(color: Colors.white,fontSize: 16,height:1),
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            label: label != null ? Text(label!,style: TextStyle(color: Colors.white.withOpacity(0.4)),) : null,
            filled: true,
            floatingLabelStyle: TextStyle(fontSize: 14,height: 1),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 20,height: 1,fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 35),


          ),
        ),
      ),
    );
  }
}
