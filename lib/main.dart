// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/testlogin.dart';
import 'package:saloon_app/views/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/controller/auth/login_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var loginController = Get.put(AuthController());
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginController.isLogin ? const Dashboard() : LoginBodyScreen(),
    );
  }
}
