import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenfemina_v2/api_repository.dart';
import 'package:zenfemina_v2/menu/calender.dart';
import 'package:zenfemina_v2/menu/editprofile.dart';
import 'package:zenfemina_v2/menu/editpw.dart';
import 'package:zenfemina_v2/pages/pages.dart';
import 'package:zenfemina_v2/pages/prayer_type.dart';
import 'package:zenfemina_v2/pages/profile_menu.dart';
import 'package:flutter/services.dart' show AssetImage;
import 'package:image_picker/image_picker.dart';
import 'package:zenfemina_v2/widgets/color_extension.dart';
import 'package:zenfemina_v2/widgets/round_button.dart';
import 'package:zenfemina_v2/widgets/round_textfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiRepository _apiRepository = ApiRepository();
  final ImagePicker picker = ImagePicker();
  String? dataImage;
  int? periodLength;
  int? cycleLength;

  @override
  void initState() {
    super.initState();
    fetchLengthData();
    _loadUserInfo();
  }

  Future<void> fetchLengthData() async {
    try {
      final data = await ApiRepository().getCycleData('hist');
      setState(() {
        if (data['data'] != null && data['data'] is Map<String, dynamic>) {
          final cycleData = data['data'];
          periodLength = int.parse(cycleData['period_length']);
          cycleLength = int.parse(cycleData['cycle_length']);
        }
      });
    } catch (e) {
      print('Error fetching cycle data: $e');
    }
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await _apiRepository.getUserInfo();
      dataImage = userInfo['data']['image'];
      setState(() {});
    } catch (e) {
      print('Failed to load user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building profilePage');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(220),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color(0xFFDA4256),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Profile',
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            width: 115,
                            height: 115,
                            decoration: BoxDecoration(
                              color: TColor.placeholder,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 64,
                              backgroundImage: dataImage != null
                                  ? NetworkImage(
                                      'https://v2.zenfemina.com/storage/' +
                                          dataImage!)
                                  : null,
                              child: dataImage == null
                                  ? Icon(
                                      Icons.person,
                                      size: 65,
                                      color: TColor.secondaryText,
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Informasi Terkait',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              PrayerType(
                text: "Lama Periode",
                icon: 0xf0404,
                hour: periodLength != null ? "$periodLength hari" : "N/A",
              ),
              PrayerType(
                text: "Lama Siklus",
                icon: 0xf6d5,
                hour: cycleLength != null ? "$cycleLength hari" : "N/A",
              ),
              SizedBox(height: 0),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              ProfileMenu(
                text: "Ubah Profile",
                icon: 0xf05f0,
                press: () {
                  Get.to(() => ProfileView());
                },
              ),
              ProfileMenu(
                text: "Ubah Password",
                icon: 0xf293,
                press: () {
                  Get.to(() => EditPw());
                },
              ),
              SizedBox(height: 15),
              Container(
                height: 42,
                width: MediaQuery.of(context).size.width - 2 * 20,
                child: ElevatedButton(
                  onPressed: () async {
                    // Tampilkan dialog konfirmasi logout
                    Get.defaultDialog(
                      title: 'Konfirmasi',
                      middleText: 'Anda yakin ingin Keluar?',
                      textConfirm: 'Ya',
                      textCancel: 'Batal',
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.red,
                      onConfirm: () async {
                        // Jika pengguna menekan tombol Ya, lakukan logout
                        try {
                          await ApiRepository().logoutUser();
                          Get.offAll(() => WelcomePage());
                        } catch (e) {
                          print('Error saat logout: $e');
                          Get.snackbar(
                            'Error',
                            'Gagal melakukan logout. Silakan coba lagi.',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                    );
                  },
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDA4256),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
