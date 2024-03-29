import 'package:assignment_app/pages/CartPage.dart';
import 'package:assignment_app/pages/HomePage.dart';
import 'package:assignment_app/pages/ItemPage.dart';
import 'package:assignment_app/pages/hover_page.dart';
import 'package:assignment_app/pages/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HoverPage(),
        '/signin': (context) => SignInPage(), // Default route to SignInPage
        '/home': (context) => HomePage(), // Route to HomePage
        '/itemPage': (context) => ItemPage(), // Route to ItemPage
        '/cartPage': (context) => CartPage()
        // Other routes...
      },
      // Other configurations...
    );
  }
}
