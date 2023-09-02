import 'dart:ui';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strolls/authenticator.dart';
import 'package:strolls/core/bloc/authenticator_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/features/home/presentation/pages/home_page.dart';
import 'package:strolls/features/home/presentation/pages/intro_page.dart';
import 'package:strolls/features/home/presentation/widgets/background_circle.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/gradient_nav_bar.dart';
import 'package:strolls/features/home/presentation/widgets/stroll_item.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'core/bloc/authenticator_event.dart';
import 'features/home/presentation/pages/main_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  setup();
  runApp(MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', //
    importance: Importance.max,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  var prefs = await SharedPreferences.getInstance();
  await AppMetrica.activate(
      AppMetricaConfig("00fbe501-83a5-4172-8384-f845c4ffbc71"));
  await AppMetrica.reportError(message: 'My first AppMetrica event!');
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AuthenticatorBloc>()..add(GetProfileAuthenticatorEvent()),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: Authenticator(),
      ),
    );
  }
}

