import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/add_kid.dart';
import 'package:habitos/screens/create_habit_screen.dart';
import 'package:habitos/screens/email_verification_screen.dart';
import 'package:habitos/screens/home/home_widget.dart';
import 'package:habitos/screens/loading_screen.dart';
import 'package:habitos/screens/rewards.dart';
import 'package:habitos/screens/settings.dart';
import 'package:habitos/theme/theme.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../theme/habity_icons_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userData = FirebaseFirestore.instance.collection('users');
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

        return currentUser.emailVerified
            ? WillPopScope(
                child: snapshot.hasData
                    ? userHasKids
                        ? HomePage(scaffoldKey: _scaffoldKey)
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

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      key: widget._scaffoldKey,
      extendBodyBehindAppBar: false,
      body: _bottomNavBar(),
      floatingActionButton: const FloatingButtonWidget(),
    );
  }

  Widget _bottomNavBar() {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppTheme.primary, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [const HomeWidget(), const RewardsScreen(), const SettingsScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(HabityIcons.task_alt),
        title: ("Habits"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(HabityIcons.emoji_events),
        title: ("Rewards"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(HabityIcons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }
}

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          bottom: 70,
          child: SpeedDial(
              icon: Icons.add,
              activeIcon: Icons.close,
              overlayColor: Colors.transparent,
              overlayOpacity: 0,
              backgroundColor: AppTheme.tertiary,
              foregroundColor: Colors.black,
              children: [
                SpeedDialChild(
                  child: const Icon(HabityIcons.ic_round_add_task),
                  label: 'Add habit',
                  backgroundColor: AppTheme.tertiary,
                  onTap: () => pushNewScreen(
                    context,
                    screen: const CreateHabitScreen(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ),
                ),
                SpeedDialChild(
                  child: const Icon(HabityIcons.emoji_events),
                  label: 'Add reward',
                  backgroundColor: AppTheme.tertiary,
                  onTap: () {/* Do someting */},
                ),
              ]),
        ),
      ],
    );
  }
}
