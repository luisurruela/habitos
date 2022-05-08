import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:habitos/screens/signin_screen.dart';
import 'package:habitos/theme/theme.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  bool resetMailSent = false;
  bool isLoading = false;
  bool emailError = false;
  String errorMessage = '';
  String emailText = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
            child: Container(
          height: height,
          width: width,
          decoration: AppTheme.backgroundGradient,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SafeArea(
                    child: Row(
                  children: [
                    SizedBox(
                      child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    )
                  ],
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.2),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      width: 325,
                      child: !resetMailSent
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 260,
                                  child: Column(
                                    children: const [
                                      Text(
                                        'Reset your password',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'PPAgrandir'),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Get instructions sent to this email that explain how to reset your password',
                                        style: AppTheme.fontSubTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Form(
                                  key: _formKey,
                                  child: SizedBox(
                                    width: 260,
                                    child: TextFormField(
                                      enabled: !isLoading,
                                      onChanged: (value) {
                                        if (emailError) {
                                          setState(() {
                                            emailError = false;
                                            errorMessage = '';
                                          });
                                        }
                                      },
                                      controller: email,
                                      decoration: InputDecoration(
                                        enabledBorder: emailError
                                            ? const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 2.0),
                                              )
                                            : null,
                                        floatingLabelStyle:
                                            MaterialStateTextStyle.resolveWith(
                                                (Set<MaterialState> states) {
                                          Color color = (states.contains(
                                                      MaterialState.error) ||
                                                  emailError)
                                              ? Theme.of(context).errorColor
                                              : AppTheme.primary;
                                          return TextStyle(color: color);
                                        }),
                                        focusedBorder: emailError
                                            ? const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 2.0),
                                              )
                                            : const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme.primary,
                                                    width: 2.0),
                                              ),
                                        labelText: "Email",
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                        ),
                                      ),
                                      validator: emailValidate,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                ),
                                emailError
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            left: 45,
                                            right: 45,
                                            bottom: 0),
                                        child: Center(
                                            child: Text(
                                          errorMessage,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 221, 48, 36),
                                            fontSize: 12,
                                          ),
                                        )),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(0),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: width * 0.6,
                                  height: 48,
                                  child: ElevatedButton(
                                    style: AppTheme.mainButton,
                                    onPressed: isLoading
                                        ? null
                                        : () =>
                                            _formKey.currentState!.validate()
                                                ? resetPassword()
                                                : null,
                                    child: const Text(
                                      'Reset Password',
                                      style:
                                          TextStyle(color: AppTheme.darkPurple),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          // ignore: dead_code
                          : ResetPasswordConfirmation(email: emailText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
        isLoading
            ? const loader()
            : const SizedBox(
                height: 0,
              )
      ],
    ));
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    isLoading = true;
    setState(() {});
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      resetMailSent = true;
      emailText = email.text;
      isLoading = false;
      setState(() {});
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == "user-not-found" ||
          e.code.toString() == 'invalid-email' ||
          e.code.toString() == 'too-many-requests') {
        if (e.code.toString() == "user-not-found") {
          errorMessage =
              "The Email Address that you've entered doesn't match any account, try again.";
        } else {
          errorMessage = e.message.toString();
        }
        emailError = true;
        isLoading = false;
        setState(() {});
      }
    }
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

class ResetPasswordConfirmation extends StatelessWidget {
  const ResetPasswordConfirmation({Key? key, required this.email})
      : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(children: [
      const SizedBox(
        height: 40,
      ),
      SizedBox(
        width: 260,
        child: Column(
          children: [
            const Text(
              'Check your mail',
              style: AppTheme.fontTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Follow the instructions sent to ',
                    style: AppTheme.fontSubTitle,
                    children: <TextSpan>[
                      TextSpan(
                          text: email,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: ' to recover your password.')
                    ])),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      SizedBox(
        width: width * 0.6,
        height: 48,
        child: ElevatedButton(
          style: AppTheme.mainButton,
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Login()));
          },
          child: const Text(
            'Done',
            style: TextStyle(color: AppTheme.darkPurple),
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ]);
  }
}

// ignore: camel_case_types
class loader extends StatelessWidget {
  const loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitRing(
      color: Color.fromRGBO(62, 40, 201, 1),
      size: 50.0,
    );
  }
}
