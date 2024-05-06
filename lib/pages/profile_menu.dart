// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/shared/shared.dart';
import 'package:flutter/services.dart' show AssetImage;

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final int icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Color(0xFFDA4256),
          padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
                IconData(icon, fontFamily: 'MaterialIcons'),
                size: 24,
                color: Color(0xFFDA4256),
              ),
            const SizedBox(width: 15),
            Expanded(
                child: Text(
              text,
              style: GoogleFonts.poppins(),
            )),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
