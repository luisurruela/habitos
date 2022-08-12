import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF2A1B89);
  static const Color primaryLight = Color(0xFF3E28C9);
  static const Color secondary = Color.fromRGBO(255, 130, 205, 1);
  static const Color tertiary = Color.fromRGBO(218, 240, 75, 1);
  static const Color darkGrey = Color.fromARGB(255, 120, 120, 120);
  static const Color darkPurple = Color.fromRGBO(12, 8, 40, 1);

  static const TextStyle fontTitle = TextStyle(
      fontSize: 32, fontWeight: FontWeight.w700, fontFamily: 'PPAgrandir');

  static const TextStyle fontTitleWhite = TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      fontFamily: 'PPAgrandir');

  static const TextStyle fontSubTitle = TextStyle(
    color: Color.fromARGB(255, 103, 103, 103),
    fontSize: 16,
  );

  static const TextStyle fontSubTitleWhite = TextStyle(
    color: Colors.white70,
    fontSize: 17,
  );

  static const TextStyle linkPrimary =
      TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w400);

  static ButtonStyle mainButton = ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all<Color>(AppTheme.tertiary),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))));

  static ButtonStyle mainButtonDisabled = ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFFD8D4F4)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))));

  static BoxDecoration backgroundGradient = const BoxDecoration(
      gradient:
          RadialGradient(center: Alignment(-0.3, -0.95), radius: 0.8, colors: [
    AppTheme.primary,
    AppTheme.primary,
  ]));
}
