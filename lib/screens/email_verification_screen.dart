import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/home_screen.dart';

import '../theme/theme.dart';

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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;

    if (isEmailVerified) {
      return HomeScreen();
    } else {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                height: height,
                width: width,
                decoration: AppTheme.backgroundGradient,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 325,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                                child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Verify your email!',
                                    style: AppTheme.fontTitle,
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text: 'Confirm that ',
                                              style: AppTheme.fontSubTitle,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: user!.email,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                const TextSpan(
                                                    text:
                                                        ' is your email address to finalize the Sign Up.')
                                              ])),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 48,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                elevation: MaterialStateProperty.all(
                                                    0),
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        const Color.fromRGBO(
                                                            218, 240, 75, 1)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(30))))),
                                            onPressed: canReSend ? sendEmailVerification : null,
                                            child: const Text(
                                              'Re-send',
                                              style: TextStyle(
                                                  color: AppTheme.darkPurple),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 48,
                                        child: TextButton(
                                            onPressed: () async {
                                              await FirebaseAuth.instance
                                                  .signOut();
                                              Navigator
                                                  .restorablePushReplacementNamed(
                                                      context, 'login');
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: AppTheme.darkPurple),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

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
