import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/home/navigation_menu.dart';
import 'package:habitos/screens/add_kid.dart';
import 'package:habitos/screens/email_verification_screen.dart';
import 'package:habitos/screens/loading_screen.dart';
import 'package:habitos/screens/rewards.dart';
import 'package:habitos/screens/settings.dart';
import 'package:habitos/theme/theme.dart';

import 'home/home_widget.dart';
import 'home/sidebar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final screens = [
    const HomeWidget(),
    const RewardsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                          ? IndexedStack(
                              index: _selectedIndex,
                              children: screens,
                            )
                          : const AddKidScreen(backButton: false)
                      : const LoadingScreen(),
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: AppTheme.primary,
                    elevation: 0,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle_outline),
                        label: 'Habits',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.emoji_events_outlined),
                        label: 'Rewards',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings_outlined),
                        label: 'Settings',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white.withOpacity(0.8),
                    onTap: _onItemTapped,
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: AppTheme.tertiary,
                    child: const Icon(
                      Icons.add,
                      color: AppTheme.darkPurple,
                    ),
                    onPressed: () {},
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
