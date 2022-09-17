import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF3220A1);
  static const Color primaryLight = Color(0xFF3E28C9);
  static const Color secondary = Color(0xFFFF6668);
  static const Color tertiary = Color.fromRGBO(218, 240, 75, 1);
  static const Color lightPink = Color(0xFFFF82CD);
  static const Color darkGrey = Color.fromARGB(255, 120, 120, 120);
  static const Color darkPurple = Color(0xFF191050);
  static const Color lightPurple = Color(0xFFB2A9E9);
  static const Color darkBlue = Color(0xFF251879);
  static const Color starYellow = Color(0xFFFEB701);

  static const TextStyle fontTitle = TextStyle(
      fontSize: 32, fontWeight: FontWeight.w700, fontFamily: 'PPAgrandir');

  static const TextStyle fontTitleWhite = TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      fontFamily: 'PPAgrandir');

  static const TextStyle h1 = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      fontFamily: 'PPAgrandir',
      color: Colors.white);

  static const TextStyle h2 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: 'PPAgrandir',
      color: Colors.white);

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
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
        0.4,
        0.8
      ],
          colors: [
        AppTheme.primaryLight,
        AppTheme.primary,
      ]));

  static BoxDecoration homeBackgroundGradient = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
        0.4,
        0.8
      ],
          colors: [
        AppTheme.primary,
        AppTheme.darkPurple,
      ]));
}
