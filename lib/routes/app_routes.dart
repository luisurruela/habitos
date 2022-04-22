import 'package:flutter/material.dart';
import 'package:habitos/screens/account_type_screen.dart';
import 'package:habitos/screens/home_screen.dart';
import 'package:habitos/screens/onboarding_screen.dart';
import 'package:habitos/screens/signin_screen.dart';
import 'package:habitos/screens/signup_screen.dart';

class AppRouters {
  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => HomeScreen(),
    'login': (BuildContext context) => const Login(),
    'register': (BuildContext context) => const SignUpScreen(),
    'type': (BuildContext context) => const AccountType(),
    'intro': (BuildContext context) => IntroScreen(),
  };
}
