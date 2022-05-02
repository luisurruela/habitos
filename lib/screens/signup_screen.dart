// ignore_for_file: unnecessary_const
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool registerError = false;
  bool isLoading = false;
  String error = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        gradient: RadialGradient(
                            center: Alignment(-0.3, -0.95),
                            radius: 0.8,
                            colors: [
                          Color.fromRGBO(255, 130, 205, 1),
                          Color.fromRGBO(62, 40, 201, 1),
                        ])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 325,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Hello parent!",
                                style: TextStyle(
                                    fontSize: 34, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Please, register a new account",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 120, 120, 120),
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 260,
                                      child: TextFormField(
                                        enabled: !isLoading,
                                        onChanged: (value) {
                                          if (registerError) {
                                            resetCredentials();
                                          }
                                        },
                                        controller: email,
                                        decoration: const InputDecoration(
                                            labelText: "Email",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                            )),
                                        validator: emailValidate,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                    ),
                                    registerError
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                left: 45,
                                                right: 45,
                                                bottom: 0),
                                            child: Center(
                                                child: Text(
                                              error,
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
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 260,
                                      child: TextFormField(
                                        enabled: !isLoading,
                                        onChanged: (value) {
                                          if (registerError) {
                                            resetCredentials();
                                          }
                                        },
                                        controller: password,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                            labelText: "Password",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                            )),
                                        validator: passwordValidate,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 260,
                                      child: TextFormField(
                                        enabled: !isLoading,
                                        onChanged: (value) {
                                          if (registerError) {
                                            resetCredentials();
                                          }
                                        },
                                        controller: confirmPassword,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                            labelText: "Confirm Password",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                            )),
                                        validator: passwordValidate,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 48,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromRGBO(
                                                  218, 240, 75, 1)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))))),
                                  onPressed: isLoading
                                      ? null
                                      : () => _formKey.currentState!.validate()
                                          ? signUp()
                                          : null,
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Color.fromRGBO(12, 8, 40, 1)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          isLoading ? const loader() : const SizedBox(height: 0)
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      email.text = '';
      password.text = '';
      confirmPassword.text = '';
      isLoading = false;
      setState(() {});

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'home');
      }
    } on FirebaseAuthException catch (e) {
      registerError = true;
      error = e.message.toString();
      isLoading = false;
      setState(() {});
      // print(e);
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

  String? passwordValidate(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }

    if (password != confirmPassword.text) {
      return "Passwords don't match.";
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void resetCredentials() {
    registerError = false;
    error = '';
    setState(() {});
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
      size: 60.0,
    );
  }
}
