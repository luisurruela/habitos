import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/home_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  bool canReSend = true;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendEmailVerification();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomeScreen()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Email Verification'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Verify your email!',
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Text(
                        'We send you an email, click the link inside to verify your account.',
                        style: TextStyle(color: Colors.black87),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                              onPressed:
                                  canReSend ? sendEmailVerification : null,
                              child: const Text('Re-send')),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.restorablePushReplacementNamed(
                                    context, 'login');
                              },
                              child: const Text('Cancel')),
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        );

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    setState(() {});

    if (isEmailVerified) timer?.cancel();
  }

  Future sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      canReSend = false;
      setState(() {});
      await Future.delayed(const Duration(seconds: 8));
    } catch (e) {
      // print(e);
    }
  }
}
