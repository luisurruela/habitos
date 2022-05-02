import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          gradient: RadialGradient(
              center: Alignment(-0.3, -0.95),
              radius: 0.8,
              colors: [
            Color.fromRGBO(255, 130, 205, 1),
            Color.fromRGBO(62, 40, 201, 1),
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            width: width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Recover your password',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                      child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                        labelText: "Email Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )),
                    validator: emailValidate,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 48,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(218, 240, 75, 1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))))),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                        } on FirebaseAuthException catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                      },
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(color: Color.fromRGBO(12, 8, 40, 1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }

  String? emailValidate(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email address';
    }

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email) ? null : 'Invalid E-mail address format.';
  }
}
