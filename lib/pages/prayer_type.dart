// ignore_for_file: deprecated_member_use

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/shared/shared.dart';
import 'package:flutter/services.dart' show AssetImage;

class PrayerType extends StatelessWidget {
  const PrayerType({
    Key? key,
    required this.text,
    required this.icon,
    required this.hour,
    this.press,
  }) : super(key: key);

  final String text, hour;
  final int icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xFFE0E0E0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3), // perubahan posisi bayangan jika diperlukan
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(
              IconData(icon, fontFamily: 'MaterialIcons'),
              size: 23,
              color: Color(0xFFDA4256),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: 15), // Atur margin kanan sesuai kebutuhan
            child: Text(
              hour,
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }
}
