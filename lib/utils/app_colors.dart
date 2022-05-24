import 'package:flutter/material.dart';

class AppColors {
  static const a = Color(0xFF81252D);
  static const b = Color(0xFF782A4A);
  static const c = Color(0xFF64355E);
  static const d = Color(0xFF4A4067);
  static const e = Color(0xFF354663);
  static const f = Color(0xFF2F4858);

  static const myGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.a,
      AppColors.b,
      AppColors.c,
      AppColors.c,
      AppColors.d,
      AppColors.e,
      AppColors.f
    ],
  );

  //wisnia
  static const primary = Color.fromARGB(255, 129, 37, 45);

  //static const secondary = Color.fromARGB(255, 171, 97, 115);
  static const secondary = Color(0xFF2F4858);
  static const background = Color.fromARGB(111, 129, 37, 45);
  //static const light = Color.fromARGB(255, 221, 207, 218);
  static const light = Color.fromARGB(255, 207, 224, 235);
  static const n = Color.fromARGB(255, 196, 106, 112);

  // static const secondary = Color(0xFF782A4A);

  // static const primary = Color.fromARGB(255, 37, 85, 64);
  // static const secondary = Color.fromARGB(255, 108, 152, 129);

  //fiolet
  // static const primary = Color.fromARGB(255, 69, 23, 63);
  // static const secondary = Color.fromARGB(255, 134, 74, 106);

  //pomaranczowy
  // static const primary = Color.fromARGB(255, 226, 150, 18);
  // static const secondary = Color.fromARGB(255, 243, 202, 147);

  //morski
  // static const primary = Color.fromARGB(255, 38, 182, 139);
  // static const secondary = Color.fromARGB(255, 123, 219, 173);

  //limonka
  // static const primary = Color.fromARGB(255, 170, 194, 64);
  // static const secondary = Color.fromARGB(255, 200, 220, 103);

  //grejfrut
  // static const primary = Color.fromARGB(255, 187, 99, 96);
  // static const secondary = Color.fromARGB(255, 232, 158, 146);

  //ogorek
  // static const primary = Color.fromARGB(255, 37, 85, 64);
  // static const secondary = Color.fromARGB(255, 108, 152, 129);
}
