import 'package:flutter/material.dart';
import 'package:habitos/screens/account_type_screen.dart';
import 'package:habitos/screens/add_kid.dart';
import 'package:habitos/screens/email_verification_screen.dart';
import 'package:habitos/screens/forget_password.dart';
import 'package:habitos/screens/home_screen.dart';
import 'package:habitos/screens/onboarding_screen.dart';
import 'package:habitos/screens/signin_screen.dart';
import 'package:habitos/screens/signup_screen.dart';

class AppRouters {
  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    'login': (BuildContext context) => const Login(),
    'register': (BuildContext context) => const SignUpScreen(),
    'type': (BuildContext context) => const AccountType(),
    'intro': (BuildContext context) => IntroScreen(),
    'forget-password': (BuildContext context) => const ForgetPassword(),
    'add-kid': (BuildContext context) => const AddKidScreen(),
    'email-verification': (_) => const EmailVerificationScreen()
  };
}
