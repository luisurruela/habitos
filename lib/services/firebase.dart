import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  final _collectionRef = FirebaseFirestore.instance.collection('children');

  Future getChildren() async {
    final query = await _collectionRef
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    List children = query.docs.map((doc) => doc.data()).toList();
    return children;
  }

  Future addHabit(data) async {
    CollectionReference users = FirebaseFirestore.instance.collection('habits');
    return users.add(data);
  }
}
