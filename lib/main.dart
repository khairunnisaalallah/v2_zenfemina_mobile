import 'package:flutter/material.dart';
import 'package:zenfemina_v2/pages/login.dart';
import 'package:zenfemina_v2/pages/pages.dart';
// import 'pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}