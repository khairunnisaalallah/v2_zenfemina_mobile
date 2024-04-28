import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenfemina_v2/navigation/article.dart';
import 'package:zenfemina_v2/navigation/dashboard.dart';
import 'package:zenfemina_v2/navigation/profile.dart';
import 'package:zenfemina_v2/menu/calender.dart';
import 'package:zenfemina_v2/pages/cobadisini.dart';
import 'package:zenfemina_v2/pages/login.dart';
import 'package:zenfemina_v2/pages/home.dart';
import 'package:zenfemina_v2/pages/pages.dart';
import 'package:zenfemina_v2/pages/question1.dart';
import 'package:zenfemina_v2/pages/register.dart';
import 'package:zenfemina_v2/pages/splash_screen.dart';
import 'package:zenfemina_v2/pages/range_date.dart';
import 'package:zenfemina_v2/pages/profile_pic.dart';
import 'package:zenfemina_v2/pages/profile_menu.dart';

// import 'pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true, // Tambahkan ini
      home: home(),
    );
  }
}
