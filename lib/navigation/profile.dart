import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenfemina_v2/pages/profile_menu.dart';
import 'package:zenfemina_v2/pages/profile_pic.dart';
import 'package:flutter/services.dart' show AssetImage;

class profilePage extends StatelessWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building profilePage');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 250,
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
                    SizedBox(height: 20),
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip
                            .none, //ini biar widgetnya ga kepangkas atau kepotong
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/tennis.png"),
                          ),
                          Positioned(
                            right: -16,
                            bottom: 0,
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                  backgroundColor: const Color(0xFFF5F6F9),
                                ),
                                onPressed: () {},
                                child: SvgPicture.asset(
                                    "assets/images/cameraicon.svg"),
                              ),
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
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              ProfileMenu(
                text: "Lama Periode",
                icon: "assets/images/period.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Lama Siklus",
                icon: "assets/images/cycle.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Ubah Profile",
                icon: "assets/images/editprofile.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Ubah Password",
                icon: "assets/images/editpw.svg",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
