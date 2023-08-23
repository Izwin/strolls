import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:strolls/features/chat/domain/entities/message_entity.dart';

class MyMessageItemWidget extends StatelessWidget {
  MyMessageItemWidget({required this.messageEntity, super.key});

  MessageEntity messageEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 100, minWidth: 50),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFDD6969),
                    border: const GradientBoxBorder(
                        width: 1,
                        gradient: LinearGradient(colors: [
                          Color(0x66FFFFFF),
                          Color(0x66000000),
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    borderRadius: BorderRadius.circular(24)),
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                child: Text(
                  messageEntity.message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
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
