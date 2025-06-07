import 'package:frontend/pages/home.dart';
import 'package:frontend/pages/cart.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/services/get_it_dependency_injection.dart';
import 'package:frontend/services/login_connection.dart';
import 'package:frontend/services/persistant_storage.dart';
import 'package:frontend/web_api/dto/email_password.dart';
import 'package:frontend/web_api/http_override.dart';
import 'package:get_it/get_it.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  MyApp({super.key}) {
    setupDependencyInjection(navigatorKey);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomePage(),
      routes: {
        '/cart': (context) => CartPage(),
      },
    );
  }
}
