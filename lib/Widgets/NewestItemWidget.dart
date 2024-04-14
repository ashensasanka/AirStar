import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewestItemWidget extends StatelessWidget {
  final String? userName;

  const NewestItemWidget({Key? key, this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('newest').snapshots(),
      builder: (context, snapshot) {
        List<Widget> itemWidgets = [];
        if (!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        } else {
          final items = snapshot.data?.docs.reversed.toList();
          for (var item in items!){
            final itemWidget = buildItem(
              context,
              item['imageUrl'],
              item['name'],
              item['subtitle'],
              "\R\S ${item['price']}",
              userName
            );
            itemWidgets.add(itemWidget);
          }
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              children: itemWidgets,
            ),
          ),
        );
      }
    );
  }

  Widget buildItem(BuildContext context, String image, String title, String description, String price, String? userName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity, // Adjusted to take full width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/itemPage",
                  arguments: {
                    'image': image,
                    'title': title,
                    'price': price,
                    'userName':userName
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: 150.0, // Specify fixed width for image container
                child: Image.network(
                  image,
                  height: 120.0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5), // Added SizedBox for spacing
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5), // Added SizedBox for spacing
                    RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 18,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      onRatingUpdate: (index) {},
                    ),
                    SizedBox(height: 5), // Added SizedBox for spacing
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 26,
                  ),
                  Icon(
                    CupertinoIcons.cart,
                    color: Colors.red,
                    size: 26,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
