import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../services/firestore.dart';

class DrawerWidget extends StatefulWidget {
  final String? userName;

  DrawerWidget({Key? key, this.userName}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;

  Future<void> _getImageFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  final FireStoreService fireStoreService = FireStoreService();
  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
                fireStoreService.addProPic(
                  widget.userName,
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

              Navigator.pop(context);
            },
            child: Text("Add Image"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              accountName: StreamBuilder<DocumentSnapshot>(
                stream: _firestore.collection('users').doc(widget.userName).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final DocumentSnapshot document = snapshot.data!;
                  final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  return Text('${data['username']}',style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),);
                },
              ),
              accountEmail: StreamBuilder<DocumentSnapshot>(
                stream: _firestore.collection('users').doc(widget.userName).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final DocumentSnapshot document = snapshot.data!;
                  final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  return Text('${data['email']}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),);
                },
              ),
              currentAccountPicture: GestureDetector(
                onTap: openNoteBox,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: _firestore.collection('users').doc(widget.userName).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final DocumentSnapshot document = snapshot.data!;
                    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return data['imageUrl'] == null? CircleAvatar(
                      backgroundImage: AssetImage("assets/propic.png"),
                    ):CircleAvatar(
                      backgroundImage: NetworkImage("${data['imageUrl']}"),
                    );
                  },
                ),
              ),
            ),
          ),

          // Home
          ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.red,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to Home Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/HomePage');
            },

          ),

          // My Account
          ListTile(
            leading: Icon(
              CupertinoIcons.person,
              color: Colors.red,
            ),
            title: Text(
              "My Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to My Account Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/my_account');
            },
          ),

          // My Orders
          ListTile(
            leading: Icon(
              CupertinoIcons.cart_fill,
              color: Colors.red,
            ),
            title: Text(
              "My Orders",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to My Orders Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/my_orders');
            },
          ),

          // My Wish List
          ListTile(
            leading: Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
            ),
            title: Text(
              "My Wish List",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to My Wish List Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/my_wish_list');
            },
          ),

          // Settings
          ListTile(
            leading: Icon(
              CupertinoIcons.settings,
              color: Colors.red,
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to Settings Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/settings');
            },
          ),

          // Log Out
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              // Sign out the current user
              try {
                // Navigate to the login screen or home screen after sign out
                // Example:
                Navigator.pushNamed(context, '/signin');
              } catch (e) {
                print('Error signing out: $e');
                // Handle signout error
              }
            },
          ),
        ],
      ),
    );
  }
}
