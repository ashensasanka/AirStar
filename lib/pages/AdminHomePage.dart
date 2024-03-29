import 'package:flutter/material.dart';

import 'NewestPage.dart';
import 'approve_cart.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the next page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewestPage()),
                );
              },
              child: Text('Newest Page'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the next page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApproveCartPage()),
                );
              },
              child: Text('Approve Cart Page'),
            ),
          ),
        ],
      ),
    );
  }
}
