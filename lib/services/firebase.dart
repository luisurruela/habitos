import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitos/models/habit_model.dart' as model;

class Firebase {
  Future getChildren() async {
    final _collectionRef = FirebaseFirestore.instance.collection('children');
    final query = await _collectionRef
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    List results = query.docs.map((doc) => doc.data()).toList();
    return results;
  }

  Future addHabit(model.Habit data) async {
    CollectionReference habits =
        FirebaseFirestore.instance.collection('habits');
    return await habits.add(data.toJson()).then((value) {
      habits.doc(value.id).update({'id': value.id});
    });
  }

  Future getHabits(String child) async {
    final _collectionRef = FirebaseFirestore.instance.collection('habits');
    final query = await _collectionRef.where('childId', isEqualTo: child).get();

    List results = query.docs.map((doc) => doc.data()).toList();
    return results;
  }
}
