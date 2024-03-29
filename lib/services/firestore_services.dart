import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreAuthServices {
  //get user
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  //create user
  Future<void> addUser(String username, String email, String password) {
    // Add a new document to the 'notes' collection with note content and timestamp
    return users.doc(email).set({
      'username': username,
      'email': email,
      'password': password
    });
  }
}