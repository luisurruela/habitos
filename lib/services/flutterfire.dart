import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> signUp() async {
  await Firebase.initializeApp();

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'luis.urruela@gmail.com', password: '123123');
    print('success');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is weak');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print.toString();
  }
}
