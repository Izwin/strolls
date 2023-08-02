import 'dart:ui';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
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

import 'features/home/presentation/pages/main_page.dart';

Future<void> main() async {
  setup();
  runApp( MyApp());
  final wsUrl = Uri.parse('ws://10.0.2.2:8080/chat');
  var channel = WebSocketChannel.connect(wsUrl);


  channel.stream.listen((message) {
    print(message);
    print("SDFSFS");
    channel.sink.add('received!');
  });
  channel.sink.add("{\"hello\" : \"hello\"}");

  var prefs = await SharedPreferences.getInstance();
  await AppMetrica.activate(AppMetricaConfig("00fbe501-83a5-4172-8384-f845c4ffbc71"));
  await AppMetrica.reportError(message: 'My first AppMetrica event!');
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Authenticator(),
    );
  }
}


