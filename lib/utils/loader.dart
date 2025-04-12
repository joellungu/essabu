import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  static load() {
    Get.dialog(
      Center(
        child: Container(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
