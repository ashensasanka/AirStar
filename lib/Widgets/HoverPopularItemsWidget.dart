import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HoverPopularItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('popular').snapshots(),
      builder: (context, snapshot) {
        List<Widget> itemWidgets = [];
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          final items = snapshot.data?.docs.reversed.toList();
          for (var item in items!) {
            final itemWidget = Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 170.0,
                height: 225.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        //-------------------------------//
                        onTap: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 1.0),
                          alignment: Alignment.center,
                          child: Image.network(
                            item['imageUrl'],
                            height: 130.0,
                          ),
                        ),
                      ),
                      Text(
                        item['name'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        item['subtitle'],
                        style: TextStyle(
                          fontSize: 15.0,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\R\S ${item['price']}.00",
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 26.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
            itemWidgets.add(itemWidget);
          }
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Row(
              children: [
                ...itemWidgets,
              ],
            ),
          ),
        );
      },
    );
  }
}
