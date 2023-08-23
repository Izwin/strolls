import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/notification/domain/entities/notification_entity.dart';
import 'package:strolls/features/profile/presentation/widgets/rouned_avatar.dart';

class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget({required this.notificationEntity,required this.onDecline,required this.onAccept,super.key});

  NotificationEntity notificationEntity;

  Function(NotificationEntity) onAccept;
  Function(NotificationEntity) onDecline;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedAvatar(
              url: notificationEntity.sender.avatarUrl,
              size: 70,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  notificationEntity.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          onAccept.call(notificationEntity);
                        },
                        splashColor: Colors.red,
                        highlightColor: Colors.red,
                        child: Container(
                          child: Text(
                            "Accept",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          onDecline.call(notificationEntity);
                        },
                        child: Container(
                          child: Text(
                            "Decline",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.15)),
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
