import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      // ignore: unused_local_variable
      UserCredential _user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = _user.user;
      user!.updateDisplayName(name);
      // print(_user.user!.uid.toString());
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

  Future<void> logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<User?> getUser() async {
    final user = firebaseAuth.currentUser;
    return user;
  }

  Future<bool> isLogIn() async {
    final currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }
}
