import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/home/calendar_widget.dart';
import 'package:habitos/screens/home/habits_widget.dart';

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
  final _collectionRef = FirebaseFirestore.instance.collection('children');

  @override
  void initState() {
    super.initState();
    getChildren();
  }

  void getChildren() async {
    final query = await _collectionRef
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    children = query.docs.map((doc) => doc.data()).toList();
    setState(() {});
    setChild(0);
  }

  void setChild(index) {
    selectedChild = index;
    childName = children[index]['name'].toString();
    childPoints = children[index]['points'].toString();
    childInitial =
        children[index]['name'].toString().substring(0, 1).toUpperCase();
    setState(() {});
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
                const SizedBox(
                  height: 20,
                ),
                const Calendar(),
                const Habtis()
              ],
            ),
          ),
        ),
      ),
    );
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const Login()));
                },
                icon: const Icon(Icons.notifications_outlined),
                iconSize: 26,
              ),
              padding: const EdgeInsets.all(0)),
        )
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddKidScreen()));
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
