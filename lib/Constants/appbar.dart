import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';

myappbar(String text) {
  return AppBar(
    title: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: backgroundColor,
    leading: InkWell(
      onTap: (() {
        Get.back();
      }),
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    ),
  );
}
