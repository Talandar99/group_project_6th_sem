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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UserConnection loginConnectionService = GetIt.I<UserConnection>();
  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();
  String token = '';
  String text = 'hello there';

  Future<void> registerTest() async {
    var x = await loginConnectionService.register(
      EmailPasswordDto(
        email: "user@example.com",
        password: "securepassword123",
      ),
    );
    print("=========================================");
    print("status code");
    print("-----------------------------------------");
    print(x);
    print("=========================================");
    setState(() {
      text = "This is register status code:";
      token = x.toString();
    });
  }

  Future<void> loginTest() async {
    var x = await loginConnectionService.login(
      EmailPasswordDto(
        email: "user@example.com",
        password: "securepassword123",
      ),
    );
    print("=========================================");
    print("token");
    print("-----------------------------------------");
    print(x.token);
    print("=========================================");
    setState(() {
      text = "This is your token:";
      token = x.token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text),
            Text(token, style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: loginTest,
            tooltip: 'Login',
            child: const Icon(Icons.verified_user_rounded),
          ),
          FloatingActionButton(
            onPressed: registerTest,
            tooltip: 'register',
            child: const Icon(Icons.verified_user_sharp),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
