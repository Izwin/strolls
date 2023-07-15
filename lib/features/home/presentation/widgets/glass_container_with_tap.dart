import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';

class GlassContainerWithTap extends GlassContainer{
  GlassContainerWithTap({super.key, required super.child, required super.height, required super.width,super.gradient,this.onTap});
  Function? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      onTap?.call();
    },child: super.build(context));
  }
}