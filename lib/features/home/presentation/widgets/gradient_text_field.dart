import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';

class GradientTextField extends StatelessWidget {
  GradientTextField({required this.label, required this.hint, required this.controller,Key? key}) : super(key: key);
  String label;
  String hint;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 60,
      gradient: LinearGradient(
        begin: const Alignment(0.00, -1.00),
        end: const Alignment(0, 1),
        colors: [Colors.black.withOpacity(0.5), const Color(0xFF050005).withOpacity(0.5)],
      ),
      child: Center(
        child: TextField(
          controller: controller,

          style: const TextStyle(color: Colors.white,fontSize: 20,height:1),
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            label: Text(label,style: TextStyle(color: Colors.white.withOpacity(0.4)),),
            filled: true,
            floatingLabelStyle: TextStyle(fontSize: 16,height: 1),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 20,height: 1,fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 35),


          ),
        ),
      ),
    );
  }
}
