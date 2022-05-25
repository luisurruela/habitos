import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/email_verification_screen.dart';
import 'package:habitos/screens/signin_screen.dart';

import '../theme/theme.dart';

class HomeScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => currentUser!.emailVerified
      ? WillPopScope(
          child: Scaffold(
            key: _scaffoldKey,
            body: HomeWidget(currentUser: currentUser),
          ),
          onWillPop: () async {
            return true;
          })
      : const EmailVerificationScreen();
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key, required this.currentUser}) : super(key: key);

  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Column(
          children: [
            SingleChildScrollView(
              child: Container(
                height: height,
                width: width,
                decoration: AppTheme.backgroundGradient,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Column(
                        children: [
                          AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              leading: ElevatedButton(
                                child: const Text(
                                  'M',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () => selectAvatar(context),
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(255, 102, 104, 1),
                                    side: const BorderSide(
                                        width: 2, color: Colors.white),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding: const EdgeInsets.all(10)),
                              ),
                              title: const Text('Habity'),
                              actions: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: Padding(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.notifications),
                                        iconSize: 35,
                                      ),
                                      padding: const EdgeInsets.all(0)),
                                )
                              ]),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Hi there,',
                                style: TextStyle(
                                    color: Color.fromARGB(228, 255, 255, 255),
                                    fontSize: 25),
                              ),
                              Text('👋', style: TextStyle(fontSize: 25))
                            ],
                          ),
                          Row(
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      text: 'Melissa ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 30),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: 'has',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: ' 0 points',
                                        style: TextStyle(
                                          color: AppTheme.tertiary,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 30,
                                        )),
                                    TextSpan(
                                        text: ' in total',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500))
                                  ])),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: 120,
                              height: 120,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'add-kid');
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white24,
                                    size: 60,
                                  )),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppTheme.primary,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.white24, spreadRadius: 3),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        )),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: AppTheme.primary),
                        width: width,
                        height: height,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void selectAvatar(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              minLeadingWidth: 0,
              leading: const Icon(Icons.person_add),
              title: const Text('Add child'),
              onTap: () {},
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              minLeadingWidth: 0,
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}
