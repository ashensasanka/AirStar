import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  File? selectedImage;
  // Collection reference for 'notes' collection
  final CollectionReference notes = FirebaseFirestore.instance.collection('newest');
  final CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getAdminNotesStream() {
    // Stream of snapshots from 'notes' collection ordered by timestamp in descending order
    final notesStream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }
  // Method to retrieve notes from Firestore as a stream
  Stream<QuerySnapshot> getCartsStream() {
    // Stream of snapshots from 'notes' collection ordered by timestamp in descending order
    final notesStream = cart.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  Future<void> updateAdminNote(String docID, String newNote, String newSubtext,) {
    // Update the document with specified docID in 'notes' collection with new note content, subtext, and updated timestamp
    return notes.doc(docID).update({
      'note': newNote,
      'subtext': newSubtext, // Update subtext field
      'timestamp': Timestamp.now(),
    });
  }
  // Method to update an existing note in Firestore
  Future<void> updateStatus(String docID, String newStatus) {
    // Update the document with specified docID in 'notes' collection with new note content, subtext, and updated timestamp
    return cart.doc(docID).update({
      'status': newStatus,
      'timestamp': Timestamp.now(),
    });
  }

  // Method to delete a note from Firestore
  Future<void> deleteCart(String docID) {
    // Delete the document with specified docID from 'notes' collection
    return cart.doc(docID).delete();
  }
  Future<void> deleteNote(String docID) {
    // Delete the document with specified docID from 'notes' collection
    return notes.doc(docID).delete();
  }

  // Method to toggle the favorite status of a note
  Future<void> toggleFavorite(String docID, bool isFavorite) {
    // Update the document with specified docID in 'notes' collection with new favorite status
    return cart.doc(docID).update({
      'favorite': isFavorite,
    });
  }

  // Method to retrieve favorite notes from Firestore as a stream
  Stream<QuerySnapshot> getFavoriteNotesStream() {
    // Stream of snapshots from 'notes' collection where 'favorite' field is true
    final favoriteNotesStream = cart.where('favorite', isEqualTo: true).snapshots();
    return favoriteNotesStream;
  }

  addCart(String name, String image, double prices) async {
    return cart.add({
      'name': name,
      'price':prices,
      'timestamp': Timestamp.now(),
      'imageUrl':image,
      'status':'Pending'
    });
  }
  addItem(String note, String subnote, String prices, File? selectedImage, String filetype) async {

    final imagePath = 'newest/item${DateTime.now().millisecondsSinceEpoch}';
    final Reference storageReference = storage.ref().child(imagePath);
    double price = double.parse(prices);

    // Specify content type as 'image/jpeg'
    final metadata = SettableMetadata(contentType: filetype);

    await storageReference.putFile(selectedImage!, metadata);
    final String imageUrl = await storageReference.getDownloadURL();

    return notes.add({
      'name': note,
      'price':price,
      'timestamp': Timestamp.now(),
      'subtitle': subnote, // Initialize subtext field with an empty string
      'imageUrl':imageUrl
    });
  }
}
