import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitos/models/habit_model.dart' as model;

class Firebase {
  final _collectionRef = FirebaseFirestore.instance.collection('children');

  Future getChildren() async {
    final query = await _collectionRef
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    List children = query.docs.map((doc) => doc.data()).toList();
    return children;
  }

  Future addHabit(model.Habit data) async {
    CollectionReference habits =
        FirebaseFirestore.instance.collection('habits');
    return await habits.add(data.toJson()).then((value) {
      habits.doc(value.id).update({'id': value.id});
    });
  }
}
