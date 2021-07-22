import 'package:cloud_firestore/cloud_firestore.dart';

class AuthCredentials {
  final String id;
  late final String title;
  late final String content;
  late final String time;
  AuthCredentials({
    this.id = '',
    required this.title,
    required this.time,
    required this.content,
  });

  static AuthCredentials fromSnapShot(DocumentSnapshot snap) {
    var snaps = snap.data();
    return AuthCredentials(
        id: (snaps as dynamic)["id"] ?? "",
        title: (snaps as dynamic)["title"],
        time: (snaps as dynamic)["time"],
        content: (snaps as dynamic)["content"]);
  }
}

Map<String, dynamic> toMap(
    String title, String time, String content, String id) {
  return {
    "id": id,
    "title": title,
    "time": time,
    "content": content,
  };
}
