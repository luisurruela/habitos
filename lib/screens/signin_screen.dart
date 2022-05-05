import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:habitos/screens/home_screen.dart';
import 'package:habitos/screens/signup_screen.dart';
import 'package:habitos/theme/theme.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool emailError = false;
  bool passwordError = false;
  String error = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                      gradient: RadialGradient(
                          center: Alignment(-0.3, -0.95),
                          radius: 0.8,
                          colors: [
                        AppTheme.secondary,
                        AppTheme.primary,
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: 200,
                        child: Image(
                            image:
                                AssetImage('assets/images/signing-image.png')),
                      ),
                      const SizedBox(
                        height: 30,
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
                              "Welcome back",
                              style: AppTheme.fontTitle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Login to your account",
                              style: AppTheme.fontSubTitle,
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
                                        if (emailError) {
                                          setState(() {
                                            emailError = false;
                                            error = '';
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
                                        if (passwordError) {
                                          setState(() {
                                            passwordError = false;
                                            error = '';
                                          });
                                        }
                                      },
                                      controller: password,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          enabledBorder: passwordError
                                              ? const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2.0),
                                                )
                                              : null,
                                          floatingLabelStyle:
                                              MaterialStateTextStyle
                                                  .resolveWith(
                                                      (Set<MaterialState>
                                                          states) {
                                            Color color = (states.contains(
                                                        MaterialState.error) ||
                                                    passwordError)
                                                ? Theme.of(context).errorColor
                                                : AppTheme.primary;
                                            return TextStyle(color: color);
                                          }),
                                          focusedBorder: passwordError
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
                                          labelText: "Password",
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
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
                                              color: Color.fromARGB(
                                                  255, 221, 48, 36),
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
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, 'forget-password');
                                    },
                                    child: const Text(
                                      "Forget Password?",
                                      style: AppTheme.linkPrimary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
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
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))))),
                                  onPressed: isLoading
                                      ? null
                                      : () => _formKey.currentState!.validate()
                                          ? signIn()
                                          : null,
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Color.fromRGBO(12, 8, 40, 1)),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen())),
                          child: const Text(
                            'Register a new account',
                            style: TextStyle(
                                color: AppTheme.tertiary, fontSize: 16),
                          ))
                    ],
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
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });
    resetCredentials();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      isLoading = false;
      setState(() {});
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == "user-not-found" ||
          e.code.toString() == 'invalid-email' ||
          e.code.toString() == 'too-many-requests') {
        if (e.code.toString() == "user-not-found") {
          error =
              "The Email Address that you've entered doesn't match any account, try again.";
        } else {
          error = e.message.toString();
        }
        emailError = true;
        isLoading = false;
        setState(() {});
      }

      if (e.code.toString() == 'wrong-password') {
        passwordError = true;
        error = "The Password that you've entered is incorrect, try again";
        isLoading = false;
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
