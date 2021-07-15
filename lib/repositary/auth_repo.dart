import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp({required String email, required String password}) async {
    try {
      UserCredential _user = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(_user.user!.uid.toString());
    } on FirebaseAuthException catch (e) {
      var messgae = e.code.toString();
      print(messgae);
      throw Exception(messgae);
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      UserCredential _user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_user.user!.uid.toString());
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      throw Exception(e.code.toString());
    }
  }
}
