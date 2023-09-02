import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsBadgeWidget extends StatelessWidget {
  NotificationsBadgeWidget({required this.count,super.key});
  int count;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 35,
        height: 35,
        margin: const EdgeInsets.only(top: 4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFFFE5BF), Color(0xFFFFC555)],
          ),
        ),
        child: Center(
          child: Text(
            "$count",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ));
  }
}
