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
                child: snapshot.hasData
                    ? userHasKids
                        ? Home(scaffoldKey: _scaffoldKey)
                        : const AddKidScreen()
                    : const LoadingScreen(),
                onWillPop: () async {
                  return true;
                })
            : const EmailVerificationScreen();
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: const HomeWidget(),
      bottomNavigationBar: const NavigationMenu(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.tertiary,
        child: const Icon(
          Icons.add,
          color: AppTheme.darkPurple,
        ),
        onPressed: () {},
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: const HomeWidget(),
      bottomNavigationBar: const NavigationMenu(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.tertiary,
        child: const Icon(
          Icons.add,
          color: AppTheme.darkPurple,
        ),
        onPressed: () {},
      ),
    );
  }
}
