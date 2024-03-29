import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../services/firestore.dart';

class NewestPage extends StatefulWidget {
  const NewestPage({Key? key}) : super(key: key);

  @override
  _NewestPageState createState() => _NewestPageState();
}

class _NewestPageState extends State<NewestPage> {
  final FireStoreService fireStoreService = FireStoreService();
  final TextEditingController textController = TextEditingController();
  final TextEditingController subtextController = TextEditingController();
  final TextEditingController priceTextController = TextEditingController();// Add TextEditingController for subtext
  late Stream<QuerySnapshot> _notesStream;
  String _searchText = '';
  bool _ascendingOrder = true;
  bool _isDarkMode = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    _notesStream = fireStoreService.getAdminNotesStream();
  }
  Future<void> _getImageFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Item',
              ),
            ),
            TextField(
              controller: subtextController, // Use subtextController for subtext TextField
              decoration: InputDecoration(
                labelText: 'Discription',
              ),
            ),
            TextField(
              controller: priceTextController, // Use subtextController for subtext TextField
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap:  _getImageFromGallery,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color
                  borderRadius:
                  BorderRadius.circular(20), // Round the borders
                ),
                child: _image != null
                    ? Image.file(
                  _image!,
                  fit: BoxFit.cover,
                )
                    : Icon(
                  Icons
                      .add_photo_alternate, // Add an icon for image selection
                  size: 50,
                  color: Colors.grey, // Set the icon color
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                fireStoreService.addItem(
                  textController.text,
                  subtextController.text,
                  priceTextController.text,
                  _image,
                  'image'
                );
                Fluttertoast.showToast(
                  msg: "Note added successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
              } else {
                fireStoreService.updateAdminNote(
                  docID,
                  textController.text,
                  subtextController.text,

                );
              }
              textController.clear();
              subtextController.clear();
              priceTextController.clear();
              Navigator.pop(context);
            },
            child: Text("Add Note"),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _searchText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Search notes...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Taking Notes"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _ascendingOrder = !_ascendingOrder;
                });
              },
              icon: Icon(_ascendingOrder ? Icons.arrow_upward : Icons.arrow_downward),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: openNoteBox,
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: _buildSearchBar(),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _notesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List notesList = snapshot.data!.docs;
                    if (_searchText.isNotEmpty) {
                      notesList = notesList.where((note) {
                        final String noteText = note['name'];
                        return noteText.toLowerCase().contains(_searchText.toLowerCase());
                      }).toList();
                    }
                    if (!_ascendingOrder) {
                      notesList = notesList.reversed.toList();
                    }
                    return ListView.builder(
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = notesList[index];
                        String docID = document.id;

                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        String noteText = data['name'];
                        String subtext = data['subtitle'] ?? ''; // Get subtext or use empty string if not available

                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                noteText,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                subtext,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => openNoteBox(docID: docID),
                                icon: Icon(Icons.settings),
                              ),
                              IconButton(
                                onPressed: () {
                                  _confirmDelete(context, docID);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("No Notes!"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, String docID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this note?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                fireStoreService.deleteNote(docID);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
