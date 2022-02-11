import 'package:contact_ui/pages/contact_page.dart';
import 'package:contact_ui/pages/home_page.dart';
import 'package:contact_ui/pages/wifi_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        HomePage.id: (context)=>HomePage(),
        ContactPage.id: (context)=>ContactPage(),
        WiFiPage.id: (context)=>WiFiPage(),
      },

    );
  }
}


