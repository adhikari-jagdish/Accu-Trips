import 'package:accu_trips/app/routes/app_routes.dart';
import 'package:accu_trips/common/widgets/side_nav/side_nav_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // Global GetX config (recommended for production)
  Get.config(enableLog: kDebugMode);

  Get.put(SideNavController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      smartManagement: SmartManagement.onlyBuilder,
      title: 'AccuTrips',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),

      home: MaterialApp.router(routerConfig: router, debugShowCheckedModeBanner: false),
    );
  }
}
