import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:clippy_flutter/arc.dart';
import '../Widgets/AppBarWidget.dart';
import '../Widgets/ItemBottomNavBar.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int itemCount = 1; // Initially set the item count to 1
  double totalAmount = 2900.00; // Initially set the total amount

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String image = args['image'];
    final String title = args['title'];
    final String price = args['price'];
    final prices = price.replaceAll(RegExp(r'[^0-9.]'), '');
    double doubleValue = double.parse(prices);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: ListView(
          children: [
            AppBarWidget(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.network(
                image,
                height: 300.0,
              ),
            ),
            Arc(
              edge: Edge.TOP,
              arcType: ArcType.CONVEY,
              height: 30.0,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 60.0,
                          bottom: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            Text(
                              "\R\S ${doubleValue.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 130.0,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (itemCount > 1) {
                                        setState(() {
                                          itemCount--;
                                          doubleValue = itemCount * doubleValue; // Update total amount
                                        });
                                      }
                                    },
                                  ),
                                  Text(
                                    itemCount.toString(),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.plus,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        itemCount++;
                                        doubleValue = itemCount * doubleValue; // Update total amount
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Taste Our Hot Pizza at low price, This is famous pizza and you will love it.it will cost you at low price, we hope you will enjoy and order many times.",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.justify,
                      ),
                      // Remaining content...
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ItemBottomNavBar(
        name:title,
        image:image,
        totalAmount: doubleValue,
      ),
    );
  }
}
