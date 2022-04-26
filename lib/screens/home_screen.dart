import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/signin_screen.dart';

class HomeScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: const sidebar(),
          appBar: AppBar(
            title: const Text('Kids Habits'),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'add-kid');
                      },
                      child: const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 204, 204, 204),
                        size: 80,
                      )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.shade50,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 214, 214, 214),
                          spreadRadius: 3),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return true;
        });
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
