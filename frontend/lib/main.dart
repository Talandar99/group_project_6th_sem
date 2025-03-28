import 'package:frontend/pages/home.dart';
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
    );
  }
}

//  final UserConnection loginConnectionService = GetIt.I<UserConnection>();
//  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();
//  Future<void> registerTest() async {
//    var x = await loginConnectionService.register(
//      EmailPasswordDto(
//        email: "user@example.com",
//        password: "securepassword123",
//      ),
//    );
//    print("=========================================");
//    print("status code");
//    print("-----------------------------------------");
//    print(x);
//    print("=========================================");
//    setState(() {
//      text = "This is register status code:";
//      token = x.toString();
//    });
//  }
//
//  Future<void> loginTest() async {
//    var x = await loginConnectionService.login(
//      EmailPasswordDto(
//        email: "user@example.com",
//        password: "securepassword123",
//      ),
//    );
//    print("=========================================");
//    print("token");
//    print("-----------------------------------------");
//    print(x.token);
//    print("=========================================");
//    setState(() {
//      text = "This is your token:";
//      token = x.token;
//    });
//  }
