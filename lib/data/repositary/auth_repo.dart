import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logss/common/constants/text.dart';

class AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final GoogleSignInAccount? _googleUser;
  GoogleSignInAccount get user => _googleUser!;

  Future<void> googleSignIn() async {
    try {
      _googleUser = await GoogleSignIn().signIn();
      //get auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await _googleUser!.authentication;
      //creating a new credentials
      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await firebaseAuth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw e.code.toString();
    }
  }

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
      throw (e.code.toString());
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      UserCredential _user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_user.user!.uid.toString());
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      throw (e.code.toString());
    }
  }

  Future<void> logOut() async {
    try {
      User? _user = getUser();
      //if this is not checked then platform exception will be thrown
      if (_user!.providerData[0].providerId == 'google.com') {
        //this code will be executed only if user is signed in by his/her google account
        print(_user.providerData[0].providerId);
        await GoogleSignIn().disconnect();
      }
      await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

//will provide the User details
  User? getUser() {
    final user = firebaseAuth.currentUser;
    return user;
  }

  void setUserName() {
    final user = getUser();
    TextConstant.displayName = user!.email;
  }

  Future<bool> isLogIn() async {
    final currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }
}
