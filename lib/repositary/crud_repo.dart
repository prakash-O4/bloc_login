import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logss/model/user_details.dart';

class CRUDRepo {
  final firestoreC = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("notes");

  Future<void> addNotes(AuthCredentials authCredentials) async {
    var _id = users.doc().id;
    users
        .doc(_id)
        .set(
          toMap(
            authCredentials.title,
            authCredentials.time,
            authCredentials.content,
            _id,
          ),
        )
        .then((value) => print("after"));
  }

  Stream<List<AuthCredentials>> getArticles() {
    return users.snapshots().map((snapshot) {
      return snapshot.docs
          .map((data) => AuthCredentials.fromSnapShot(data))
          .toList();
    });
  }

  Future<void> deleteArticles(AuthCredentials authCredentials) async {
    // users.where("id", isEqualTo: authCredentials.id).get().then((value) {
    //   value.docs.forEach((element) {
    //     users.doc(element.id).delete().then((value) {});
    //   });
    // });
    users.doc(authCredentials.id).delete().then((value) => print("deleted"));
  }

  Future<void> updateArticles(AuthCredentials authCredentials) async {
    users
        .doc(authCredentials.id)
        .update(
          toMap(
            authCredentials.title,
            authCredentials.time,
            authCredentials.content,
            authCredentials.id,
          ),
        )
        .then((value) => print("Updated"));
  }
}
