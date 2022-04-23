import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/signin_screen.dart';

class HomeScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Kids Habits'),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hello!',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const Login()));
                    },
                    child: const Text('Sign out')),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return true;
        });
  }
}
