import 'package:cloud_firestore/cloud_firestore.dart';

class AuthCredentials {
  final String id;
  late final String title;
  late final String content;
  late final String time;
  late final String image;
  AuthCredentials({
    this.id = '',
    required this.title,
    required this.time,
    required this.content,
    this.image = '',
  });

  static AuthCredentials fromSnapShot(DocumentSnapshot snap) {
    var snaps = snap.data();
    return AuthCredentials(
      id: (snaps as dynamic)["id"] ?? "",
      title: (snaps as dynamic)["title"],
      time: (snaps as dynamic)["time"],
      content: (snaps as dynamic)["content"],
      image: (snap as dynamic)["image"] ?? "",
    );
  }

  static Map<String, dynamic> toMap(
      String title, String time, String content, String id,
      {String? image, bool? likes}) {
    return {
      "id": id,
      "title": title,
      "time": time,
      "content": content,
      "image": image,
    };
  }
}
