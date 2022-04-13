import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                          Colors.purpleAccent,
                          Colors.amber,
                          Colors.blue,
                        ])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 200,
                          width: 300,
                          child:
                              LottieBuilder.asset("assets/lottie/login2.json"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 325,
                          height: 470,
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
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Please, register a new account",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const SizedBox(
                                width: 260,
                                height: 60,
                                child: TextField(
                                  decoration: InputDecoration(
                                      suffix: Icon(
                                        FontAwesomeIcons.envelope,
                                        color: Colors.red,
                                      ),
                                      labelText: "Email Address",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const SizedBox(
                                width: 260,
                                height: 60,
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      suffix: Icon(
                                        FontAwesomeIcons.eyeSlash,
                                        color: Colors.red,
                                      ),
                                      labelText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const SizedBox(
                                width: 260,
                                height: 60,
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      suffix: Icon(
                                        FontAwesomeIcons.eyeSlash,
                                        color: Colors.red,
                                      ),
                                      labelText: "Re type Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              GestureDetector(
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
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
