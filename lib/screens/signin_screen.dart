import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitos/screens/home_screen.dart';
import 'package:habitos/screens/signup_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool emailError = false;
  bool passwordError = false;
  String error = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 5,
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
                          "Hello",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Please Login to Your Account",
                          style: TextStyle(
                            color: Colors.grey,
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
                                  onChanged: (value) {
                                    if (emailError) {
                                      setState(() {
                                        emailError = false;
                                        error = '';
                                      });
                                    }
                                  },
                                  controller: email,
                                  decoration: const InputDecoration(
                                      labelText: "Email Address",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      )),
                                  validator: emailValidate,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                        error,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 221, 48, 36),
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
                                  onChanged: (value) {
                                    if (passwordError) {
                                      setState(() {
                                        passwordError = false;
                                        error = '';
                                      });
                                    }
                                  },
                                  controller: password,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      )),
                                  validator: passwordValidate,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                              passwordError
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
                                          color:
                                              Color.fromARGB(255, 221, 48, 36),
                                          fontSize: 12,
                                        ),
                                      )),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.all(0),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forget Password",
                                  style: TextStyle(color: Colors.deepOrange),
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate() &&
                                !emailError &&
                                !passwordError) {
                              signIn();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 250,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFF8A2387),
                                      Color(0xFFE94057),
                                      Color(0xFFF27121),
                                    ])),
                            child: TextButton(
                              onPressed: () => _formKey.currentState!.validate()
                                  ? signIn()
                                  : null,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen())),
                        child: const Text(
                          'Register a new account',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 246, 77)),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    resetCredentials();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == "user-not-found" ||
          e.code.toString() == 'invalid-email' ||
          e.code.toString() == 'too-many-requests') {
        emailError = true;
        error = e.message.toString();
        setState(() {});
      }

      if (e.code.toString() == 'wrong-password') {
        passwordError = true;
        error = e.message.toString();
        setState(() {});
      }
    }
  }

  void resetCredentials() {
    emailError = false;
    passwordError = false;
    setState(() {});
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

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
