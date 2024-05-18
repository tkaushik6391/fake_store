import 'package:fake_store/app_routes.dart';
import 'package:fake_store/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static const String id = "/";
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
            title: 'Fake Store',
            enableLog: true,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.initial,
            getPages: AppRoutes.routes,
            locale: Get.deviceLocale,
            
            supportedLocales: const <Locale>[
              Locale('en'),
            ],
            initialBinding: HomeBinding(),
          );
  }
}
