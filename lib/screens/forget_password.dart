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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Form(
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
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: email.text);
              } on FirebaseAuthException catch (e) {
                // ignore: avoid_print
                print(e);
              }
            },
            child: const Text('Reset Password'),
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
          ),
        ],
      ),
    );
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
