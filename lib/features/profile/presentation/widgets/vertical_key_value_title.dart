import 'package:flutter/cupertino.dart';

class VerticalKeyValueWidget extends StatelessWidget {
  const VerticalKeyValueWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Friends",style: TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.w400,fontSize: 20),),
        Text("200",style: TextStyle(color: Color(0xFFFFE5BF),fontWeight: FontWeight.bold,fontSize: 28,height: 0.8),)
      ],
    );
  }
}
