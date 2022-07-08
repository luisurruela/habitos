import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/add_kid.dart';
import 'package:habitos/screens/email_verification_screen.dart';
import 'package:habitos/screens/signin_screen.dart';

import '../theme/theme.dart';

class HomeScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: userData.doc(currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        bool userHasKids = false;

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> user =
              snapshot.data?.data() as Map<String, dynamic>;
          userHasKids = user['hasKids'];
        }

        return currentUser!.emailVerified
            ? WillPopScope(
                child: Scaffold(
                  key: _scaffoldKey,
                  drawer: const sidebar(),
                  body: userHasKids && snapshot.hasData
                      ? HomeWidget(currentUser: currentUser)
                      : const AddKidScreen(
                          backButton: false,
                        ),
                ),
                onWillPop: () async {
                  return true;
                })
            : const EmailVerificationScreen();
      },
    );
  }
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
                          SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ElevatedButton(
                                    child: const Text(
                                      'M',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () => showBottomModal(context),
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color.fromRGBO(
                                          255, 102, 104, 1),
                                      side: const BorderSide(
                                          width: 2, color: Colors.white),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Habity',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'PPAgrandir'),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Padding(
                                      child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {},
                                        icon: const Icon(Icons.notifications),
                                        iconSize: 30,
                                      ),
                                      padding: const EdgeInsets.all(0)),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: const [
                              Text(
                                'Hi there,',
                                style: TextStyle(
                                    color: Color.fromARGB(228, 255, 255, 255),
                                    fontSize: 18),
                              ),
                              Text('👋', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: RichText(
                                    text: const TextSpan(
                                        text: 'Luis Alejandro',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 24),
                                        children: <TextSpan>[
                                      TextSpan(
                                          text: ' has',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: ' 0 points',
                                          style: TextStyle(
                                            color: AppTheme.tertiary,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 24,
                                          )),
                                      TextSpan(
                                          text: ' in total',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500))
                                    ])),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [],
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

  void showBottomModal(BuildContext context) async {
    await showModalBottomSheet<void>(
      backgroundColor: AppTheme.darkPurple,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      builder: (context) {
        return Wrap(
          children: [
            Padding(
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      minLeadingWidth: 0,
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: ElevatedButton(
                          child: const Text(
                            'M',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(255, 102, 104, 1),
                              side: const BorderSide(
                                  width: 2, color: Colors.white),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(10)),
                        ),
                      ),
                      title: const Text(
                        'Melissa',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      minLeadingWidth: 0,
                      leading: const SizedBox(
                        width: 40,
                        child: Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        'Add new child',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddKidScreen(
                                      backButton: true,
                                    )));
                      },
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30)),
          ],
        );
      },
    );
  }

  Future<List> getChildren() async {
    var items = <dynamic>[];

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('children')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.map((e) => items.add(e));
    });

    return items;
  }
}

// ignore: camel_case_types
class sidebar extends StatelessWidget {
  const sidebar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 255,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: const <Widget>[
                  Center(
                      child: SizedBox(
                    height: 120,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 215, 242, 250),
                      child: Text(
                        'JD',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      radius: 120,
                    ),
                  )),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'John Doe',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Settings'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: const Icon(Icons.bug_report_outlined),
                title: const Text('Report a bug'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About Kids Habit'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text('Sign out'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const Login()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
