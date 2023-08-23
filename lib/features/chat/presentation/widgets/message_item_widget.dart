import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:strolls/features/chat/domain/entities/message_entity.dart';

class MessageItemWidget extends StatelessWidget {
  MessageItemWidget({required this.messageEntity, super.key});

  MessageEntity messageEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF230505),
                  border: const GradientBoxBorder(
                      width: 1,
                      gradient: LinearGradient(
                          colors: [
                            Color(0x66FFFFFF),
                            Color(0x66000000),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  borderRadius: BorderRadius.circular(32)),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Text(
                messageEntity.message,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
