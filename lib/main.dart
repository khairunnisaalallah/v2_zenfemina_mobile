import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenfemina_v2/menu/editpw.dart';
import 'package:zenfemina_v2/menu/tab_sholatpuasa.dart';
import 'package:zenfemina_v2/navigation/article.dart';
import 'package:zenfemina_v2/navigation/dashboard.dart';
import 'package:zenfemina_v2/navigation/pray.dart';
import 'package:zenfemina_v2/navigation/profile.dart';
import 'package:zenfemina_v2/menu/calender.dart';
import 'package:zenfemina_v2/pages/OTP_page.dart';
import 'package:zenfemina_v2/pages/Ubah_kataSandi.dart';
import 'package:zenfemina_v2/pages/login.dart';
import 'package:zenfemina_v2/pages/home.dart';
import 'package:zenfemina_v2/pages/pages.dart';
import 'package:zenfemina_v2/pages/question1.dart';
import 'package:zenfemina_v2/pages/questionTambahan.dart';
import 'package:zenfemina_v2/pages/register.dart';
import 'package:zenfemina_v2/pages/splash_screen.dart';
import 'package:zenfemina_v2/pages/range_date.dart';
import 'package:zenfemina_v2/pages/profile_menu.dart';
import 'package:zenfemina_v2/menu/editprofile.dart';
import 'package:zenfemina_v2/pages/verifikasiEmail.dart';
import 'package:zenfemina_v2/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:io';
import 'package:zenfemina_v2/navigation/pray copy.dart';

// import 'pages/intro_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides(); // Set HttpOverrides global
  try{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("token --> $fcmToken");
  } catch(e){
    print(e);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true, // Tambahkan ini
      getPages: Routes.pages, // Tambahkan daftar rute di sini
      home: WelcomePage()
    );
  }
}
