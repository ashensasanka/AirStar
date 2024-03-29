import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(children: [

          for(int i=0; i<10; i++)
          //--------------Single Item----------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0,3),
                    ),
                  ]
              ),
              child: Image.asset(
                "assets/drink.png",
                width: 50.0,
                height:50.0,
              ) ,
            ),
          ),
        ],
        ),
      ),
    );
  }
}

          //--------------Single Item----------------
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: Container(
          //     padding: EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey.withOpacity(0.5),
          //             spreadRadius: 2,
          //             blurRadius: 10,
          //             offset: Offset(0,3),
          //           ),
          //         ]
          //     ),
          //     child: Image.asset(
          //       "assets/cheesy.png",
          //       width: 50.0,
          //       height:50.0,
          //     ) ,
          //   ),
          // ),
          // //--------------Single Item----------------
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: Container(
          //     padding: EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey.withOpacity(0.5),
          //             spreadRadius: 2,
          //             blurRadius: 10,
          //             offset: Offset(0,3),
          //           ),
          //         ]
          //     ),
          //     child: Image.asset(
          //       "assets/choco.png",
          //       width: 50.0,
          //       height:50.0,
          //     ) ,
          //   ),
          // ),
          // //--------------Single Item----------------
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: Container(
          //     padding: EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey.withOpacity(0.5),
          //             spreadRadius: 2,
          //             blurRadius: 10,
          //             offset: Offset(0,3),
          //           ),
          //         ]
          //     ),
          //     child: Image.asset(
          //       "assets/bar.png",
          //       width: 50.0,
          //       height:50.0,
          //     ) ,
          //   ),
          // ),
          // //--------------Single Item----------------
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: Container(
          //     padding: EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey.withOpacity(0.5),
          //             spreadRadius: 2,
          //             blurRadius: 10,
          //             offset: Offset(0,3),
          //           ),
          //         ]
          //     ),
          //     child: Image.asset(
          //       "assets/spicy.png",
          //       width: 50.0,
          //       height:50.0,
          //     ) ,
          //   ),
          // ),
          // //--------------Single Item----------------
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: Container(
          //     padding: EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(10),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey.withOpacity(0.5),
          //             spreadRadius: 2,
          //             blurRadius: 10,
          //             offset: Offset(0,3),
          //           ),
          //         ]
          //     ),
          //     child: Image.asset(
          //       "assets/thand.png",
          //       width: 50.0,
          //       height:50.0,
          //     ) ,
          //   ),
          // ),

