import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenfemina_v2/menu/calender.dart';
import 'package:zenfemina_v2/menu/editprofile.dart';
import 'package:zenfemina_v2/pages/prayer_type.dart';
import 'package:zenfemina_v2/pages/profile_menu.dart';
import 'package:flutter/services.dart' show AssetImage;
import 'package:image_picker/image_picker.dart';
import 'package:zenfemina_v2/widgets/color_extension.dart';
import 'package:zenfemina_v2/widgets/round_button.dart';
import 'package:zenfemina_v2/widgets/round_textfield.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

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
                height: 230,
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
                    SizedBox(height: 40), // Spacer untuk jarak
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Profile',
                          style: GoogleFonts.outfit(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 20),

                    //dari ini itu foto profile
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
                            child: image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.file(
                                      File(image!.path),
                                      width: 115,
                                      height: 115,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 55,
                                    color: TColor.secondaryText,
                                  ),
                          ),
                        ],
                      ),
                    ), //sampe sini edit profilenya
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
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Informasi Terkait',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              PrayerType(
                text: "Lama Periode",
                icon: 0xf0404,
                hour: "15 hari",
              ),
              PrayerType(
                text: "Lama Siklus",
                icon: 0xf6d5,
                hour: "27 hari",
              ),
              SizedBox(height: 0),
              Container(
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              ProfileMenu(
                text: "Ubah Profile",
                icon: 0xf05f0,
                press: () {
                  Get.to(ProfileView());
                },
              ),
              ProfileMenu(
                text: "Ubah Password",
                icon: 0xf293,
                press: () {},
              ),
              SizedBox(height: 15),
              Container(
                height: 42,
                width: MediaQuery.of(context).size.width - 2 * 20,
                child: ElevatedButton(
                  onPressed: () {
                    //
                  },
                  child: Text(
                    'Keluar',
                    style: GoogleFonts.outfit(
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
