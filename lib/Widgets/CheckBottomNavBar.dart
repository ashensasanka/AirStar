import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/firestore.dart';

class CheckBottomNavBar extends StatelessWidget {
  final double totalAmount;
  final String title;
  final String image;
  final String userName;

  CheckBottomNavBar({
    Key? key,
    required this.totalAmount, required this.title, required this.image,required this.userName,
  }) : super(key: key);
  final FireStoreService fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Row(
              children: [
                Text(
                  "\R\S ${totalAmount.toStringAsFixed(2)}", // Display total amount
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 5.0,
            ),
            ElevatedButton.icon(
              onPressed: () {
                String myString = totalAmount.toString();
                // openNoteBox();
                Navigator.pushNamed(context, "/itemPage",arguments: {'image': image,
                  'title': title,
                  'price': myString,
                  'userName':userName},);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0,
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              icon: Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
              label: Text(
                "Confirm Order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
