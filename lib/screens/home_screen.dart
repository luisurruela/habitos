import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/home/navigation_menu.dart';
import 'package:habitos/screens/add_kid.dart';
import 'package:habitos/screens/email_verification_screen.dart';
import 'package:habitos/screens/loading_screen.dart';
import 'package:habitos/theme/theme.dart';

import 'home/home_widget.dart';
import 'home/sidebar_widget.dart';

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
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, 'login');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> user =
              snapshot.data?.data() as Map<String, dynamic>;
          userHasKids = user['hasKids'];
        }

        return currentUser!.emailVerified
            ? WillPopScope(
                child: Scaffold(
                    backgroundColor: AppTheme.primary,
                    key: _scaffoldKey,
                    drawer: const Sidebar(),
                    extendBodyBehindAppBar: true,
                    body: snapshot.hasData
                        ? userHasKids
                            ? const HomeWidget()
                            : const AddKidScreen(backButton: false)
                        : const LoadingScreen(),
                    bottomNavigationBar: const NavigationMenu()),
                onWillPop: () async {
                  return true;
                })
            : const EmailVerificationScreen();
      },
    );
  }
}
