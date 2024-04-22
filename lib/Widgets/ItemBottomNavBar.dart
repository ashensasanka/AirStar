import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/firestore.dart';

class ItemBottomNavBar extends StatelessWidget {
  final double totalAmount;
  final String name;
  final String image;
  final String userName;

  ItemBottomNavBar({
    Key? key,
    required this.totalAmount, required this.name, required this.image,required this.userName,
  }) : super(key: key);
  final FireStoreService fireStoreService = FireStoreService();
  late Stream<QuerySnapshot> _notesStream;

  // void openNoteBox() {
  //   fireStoreService.addCart(
  //       name,
  //       image,
  //       totalAmount
  //   );
  //   Fluttertoast.showToast(
  //     msg: "Note added successfully",
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     backgroundColor: Colors.green,
  //     textColor: Colors.white,
  //   );
  // }
  void openNoteBox() {
    fireStoreService.submitDataToFirestore(
        name,
        image,
        totalAmount,
      userName
    );
    // fireStoreService.addCart(
    //     name,
    //     image,
    //     totalAmount,
    //   userName
    // );
    Fluttertoast.showToast(
      msg: "Note added successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

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
                  "Total:",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
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
                openNoteBox();
                Navigator.pushNamed(context, "/cartPage",arguments: {'userName':userName},);
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
                "Add To Cart",
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
