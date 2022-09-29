// ignore_for_file: unnecessary_const

import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColours {
  const AppColours();

  static const Color colorStart = Color.fromARGB(255, 240, 154, 128);
  static const Color colorEnd = Color.fromARGB(161, 134, 29, 3);

  static const buttonGradient = const LinearGradient(
    colors: const [colorStart, colorEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
