import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/widgets/gradient_scaffold.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:strolls/features/notification/presentation/widgets/notification_item_widget.dart';

import '../../../../core/getit/get_it.dart';
import '../../../profile/presentation/bloc/profile/profile_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<NotificationBloc>()..add(GetNotificationsEvent()),
      child: GradientScaffold(
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is GotNotificationsState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(title: "Notifications"),
                  SizedBox(
                    height: 100,
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return NotificationItemWidget(
                        notificationEntity: state.notifications[index],
                        onDecline: (notificationEntity) {
                          context.read<NotificationBloc>().add(
                              DeclineNotificationEvent(
                                  id: notificationEntity.id));
                        },
                        onAccept: (notificationEntity) {
                          context.read<NotificationBloc>().add(
                              AcceptNotificationEvent(
                                  id: notificationEntity.id));
                        },
                      );
                    },
                    itemCount: state.notifications.length,
                    shrinkWrap: true,
                  )
                ],
              );
            }
            return Column(children: [
              TitleText(title: "Notifications"),
            ]);
          },
        ),
      ),
    );
  }
}
