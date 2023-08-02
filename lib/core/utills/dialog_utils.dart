import 'package:flutter/cupertino.dart';

class DialogUtils{
  static void showDialog(BuildContext context, String title) {
    showCupertinoDialog(context: context, builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        actions: [CupertinoDialogAction(child: const Text("Ok"), onPressed: () {
          Navigator.pop(context);
        },)
        ],
      );
    });
  }

}
