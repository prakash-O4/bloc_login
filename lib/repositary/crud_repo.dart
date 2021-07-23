import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logss/model/user_details.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CRUDRepo {
  //this stores the single file that is picked by the user.
  late File _file;
  //this is the url where the image get stored
  String? downloadURL = "";
  //it stores picked file
  XFile? _pickedFile;
  //instance of firebase firestore
  final firestoreC = FirebaseFirestore.instance;
  //collection reference means it points towards the collection
  //here "users" point towards the collection "notes"
  CollectionReference users = FirebaseFirestore.instance.collection("notes");
  //instance of firebase storage which stores the file
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

//function which helps to add the blog with credentials
  Future<void> addNotes(AuthCredentials authCredentials) async {
    try {
      if (_pickedFile != null) {
        //creating a "ref"/Reference which points the location of the where
        //image will be located.
        Reference ref = firebaseStorage.ref().child("Blog_images").child(
              _file.uri.toString() + ".jpg",
            );
        //this helps to upload the task in the firebase storage
        UploadTask uploadTask = ref.putFile(_file);
        //wait until the task is completed.
        await uploadTask;
        //get the download link of the image where it is stored.
        downloadURL = await ref.getDownloadURL();
      }
      //generates unique document id for the document and "id" field in the model
      var _id = users.doc().id;
      users.doc(_id).set(
            toMap(
              authCredentials.title,
              authCredentials.time,
              authCredentials.content,
              _id,
              image: downloadURL,
            ),
          );
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

//function which helps to get articles from the firebase.
  Stream<List<AuthCredentials>> getArticles() {
    //users.snapshots returns the document in the stream form.
    return users.orderBy('time', descending: true).snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (data) => AuthCredentials.fromSnapShot(data),
          )
          .toList();
    });
  }

//function which will delete the articles from the server.
  Future<void> deleteArticles(AuthCredentials authCredentials) async {
    // users.where("id", isEqualTo: authCredentials.id).get().then((value) {
    //   value.docs.forEach((element) {
    //     users.doc(element.id).delete().then((value) {});
    //   });
    // });
    await users.doc(authCredentials.id).delete();
  }

//fucntion which will update the credentials but image and id will remain same as before
  Future<void> updateArticles(AuthCredentials authCredentials) async {
    await users.doc(authCredentials.id).update(
          toMap(
            authCredentials.title,
            authCredentials.time,
            authCredentials.content,
            authCredentials.id,
            image: authCredentials.image,
          ),
        );
  }

//fucntion which gets image from the device with the help of image picker package
  Future getImage() async {
    ImagePicker _imagePicker = ImagePicker();
    //get image from the device and store in the _pickedFile
    _pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    //_pickedFile will be null if users doesn't selects the image
    if (_pickedFile != null) {
      _file = File(_pickedFile!.path);
      return _file;
    }
    return null;
  }
}
