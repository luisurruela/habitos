import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/models/preference_model.dart';
import 'package:habitos/screens/home/calendar_widget.dart';
import 'package:habitos/screens/home/habits_widget.dart';
import 'package:habitos/services/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../theme/theme.dart';
import '../add_kid.dart';
import '../signin_screen.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int selectedChild = 0;
  List children = [];
  String childName = '';
  String childPoints = '0';
  String childInitial = '';
  DateTime _currentDate = DateTime.now();
  final _collectionRef = FirebaseFirestore.instance.collection('children');

  @override
  void initState() {
    super.initState();
    getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundGradient,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                header(),
                PointsBar(childName: childName, childPoints: childPoints),
                const SizedBox(height: 20),
                Calendar(function: updateSelectedDate),
                const SizedBox(height: 30),
                // Habtis(
                //   currentDate: _currentDate.toString(),
                // )
                _noHabits()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateSelectedDate(DateTime date) {
    _currentDate = date;
    setState(() {});
  }

  void getChildren() async {
    final query = await _collectionRef
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    children = query.docs.map((doc) => doc.data()).toList();
    setState(() {});

    if (await SharedPref().contains('selectedChild')) {
      // await SharedPref().remove('selectedChild');
      final preferences = await SharedPref().read('selectedChild');
      if (preferences.uid != FirebaseAuth.instance.currentUser!.uid) {
        setChild(0);
      } else {
        setChild(int.parse(preferences.selectedChild));
      }
    } else {
      setChild(0);
    }
  }

  void setChild(index) async {
    selectedChild = index;
    final PreferenceModel data = PreferenceModel.fromJson({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'selectedChild': selectedChild.toString()
    });
    SharedPref().save('selectedChild', data);

    childName = children[index]['name'].toString();
    childPoints = children[index]['points'].toString();
    childInitial =
        children[index]['name'].toString().substring(0, 1).toUpperCase();
    setState(() {});
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: ElevatedButton(
            child: Text(
              childInitial,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            onPressed: () => showBottomModal(context),
            style: ElevatedButton.styleFrom(
              primary: AppTheme.secondary,
              side: const BorderSide(width: 2, color: Colors.white),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
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
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Login();
                      },
                    ),
                    (_) => false,
                  );
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (BuildContext context) => const Login()));
                },
                icon: const Icon(Icons.notifications_outlined),
                iconSize: 26,
              ),
              padding: const EdgeInsets.all(0)),
        )
      ],
    );
  }

  Widget _noHabits() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/no_habits.png"),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Looks like you haven't created any habits yet.",
            style: TextStyle(
                fontFamily: 'PPAgrandir', color: Colors.white, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Tap + to add habits',
            style: TextStyle(
                fontFamily: 'Roboto', fontSize: 16, color: Colors.white54),
          )
        ],
      ),
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
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('children')
                            .where('uid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var child = snapshot.data!.docs[index].data();
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                minLeadingWidth: 0,
                                leading: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ElevatedButton(
                                    child: Text(
                                      child['name']
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () => showBottomModal(context),
                                    style: ElevatedButton.styleFrom(
                                      primary: AppTheme.secondary,
                                      side: const BorderSide(
                                          width: 2, color: Colors.white),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      child['name'].toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    selectedChild == index
                                        ? const Icon(
                                            Icons.done,
                                            color: AppTheme.secondary,
                                            size: 32,
                                          )
                                        : const Text(''),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  setChild(index);
                                },
                              );
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                          );
                        }),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      minLeadingWidth: 0,
                      leading: const SizedBox(
                        width: 40,
                        child: Icon(
                          Icons.person_add_alt,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        'Add new child',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        pushNewScreen(
                          context,
                          screen: const AddKidScreen(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
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
}

class PointsBar extends StatelessWidget {
  const PointsBar({
    Key? key,
    required this.childName,
    required this.childPoints,
  }) : super(key: key);

  final String childName;
  final String childPoints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Hi there,',
              style: TextStyle(
                  color: Color.fromARGB(228, 255, 255, 255), fontSize: 18),
            ),
            SizedBox(
              height: 9,
            ),
            Text('👋', style: TextStyle(fontSize: 18)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: RichText(
                  text: TextSpan(
                      text: childName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 24),
                      children: <TextSpan>[
                    const TextSpan(
                        text: ' has ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: childPoints,
                        style: const TextStyle(
                          color: AppTheme.tertiary,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        )),
                    const TextSpan(
                        text: ' points in total',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ])),
            ),
          ],
        ),
      ],
    );
  }
}
