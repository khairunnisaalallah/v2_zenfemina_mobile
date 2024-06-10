import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenfemina_v2/navigation/article.dart';
import 'package:zenfemina_v2/navigation/dashboard.dart';
import 'package:zenfemina_v2/navigation/pray.dart';
import 'package:zenfemina_v2/navigation/profile.dart';
import 'package:zenfemina_v2/menu/calender.dart';
import 'package:zenfemina_v2/pages/OTP_page.dart';
import 'package:zenfemina_v2/pages/login.dart';
import 'package:zenfemina_v2/pages/home.dart';
import 'package:zenfemina_v2/pages/pages.dart';
import 'package:zenfemina_v2/pages/question1.dart';
import 'package:zenfemina_v2/pages/question2.dart';
import 'package:zenfemina_v2/pages/question3.dart';
import 'package:zenfemina_v2/pages/question4.dart';
import 'package:zenfemina_v2/pages/register.dart';
import 'package:zenfemina_v2/pages/splash_screen.dart';
import 'package:zenfemina_v2/pages/range_date.dart';
import 'package:zenfemina_v2/pages/profile_menu.dart';
import 'package:zenfemina_v2/menu/editprofile.dart';
import 'package:zenfemina_v2/pages/verifikasiEmail.dart';
import 'package:zenfemina_v2/menu/tab_sholatpuasa.dart';
import 'package:zenfemina_v2/routes.dart';
import 'shared/shared.dart';

class Routes {
  static final List<GetPage> pages = [
    GetPage(name: '/', page: () => Home()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/register', page: () => RegisterPage()),
    GetPage(name: '/article', page: () => ArticlePage()),
    GetPage(name: '/dashboard', page: () => DashboardPage()),
    GetPage(name: '/pray', page: () => prayPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
    GetPage(name: '/calender', page: () => CalenderPage()),
    GetPage(name: '/otp', page: () => OTPPage()),
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/question1', page: () => Question1Page()),
    GetPage(name: '/question2', page: () => Question2Page()),
    GetPage(name: '/question3', page: () => Question3Page()),
    GetPage(name: '/question4', page: () => Question4Page()),
    GetPage(name: '/otp', page: () => OTPPage()),
    GetPage(name: '/editprofile', page: () => ProfileView()),
    GetPage(name: '/sholatpuasa', page: () => Tabsholatpuasa()),

    // Definisikan halaman lain sesuai kebutuhan aplikasi Anda
  ];
}
