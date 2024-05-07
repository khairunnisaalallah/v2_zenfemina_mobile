import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zenfemina_v2/shared/shared.dart';
import 'package:zenfemina_v2/widgets/color_extension.dart';
import 'package:zenfemina_v2/widgets/round_button.dart';
import 'package:zenfemina_v2/widgets/round_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  // TextEditingController _controller = TextEditingController();
  TextEditingController txt_name = TextEditingController(text: 'Azza Wafiqurrohmah');
  TextEditingController txt_email = TextEditingController(text: 'wafiqurrohmahazza@gmail.com');
  TextEditingController txt_birthDate = TextEditingController(text: '03/03/2003');

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1970, 1),
        lastDate: selectedDate,
        helpText: 'Pilih tanggal lahir mu!');
    if (picked != null && picked != selectedDate)
      setState(() {
        txt_birthDate.text = DateFormat('dd/MM/yyyy').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 23,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10), //dari sini edit profilenya
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior:
                      Clip.none, //ini biar widgetnya ga kepangkas atau kepotong
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
                              size: 65,
                              color: TColor.secondaryText,
                            ),
                    ),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          onPressed: () async {
                            image = await picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {});
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF5F6F9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            ),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/cameraicon.svg",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), //sampe sini edit profilenya

              const SizedBox(height: 30),
              Padding(
              padding: EdgeInsets.only(top: 0, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        TextFormField(
                          controller: txt_name,
                              decoration: InputDecoration(
                                labelText: "Nama Pengguna",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(width: 2.0, color: Colors.grey)
                                    ),
                                      prefixIcon: Icon(
                                      Icons.person_rounded, // Mengubah ikon email menjadi ikon kunci
                                      color: Colors.grey,
                                ),
                                  labelStyle: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                  ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(width: 2.0, color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: txt_email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 2.0, color: Colors.grey)
                            ),
                            prefixIcon: 
                            Icon(
                              Icons.markunread_rounded, // Mengubah ikon email menjadi ikon kunci
                              color: Colors.grey,
                            ),
                            labelStyle: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                              BorderSide(width: 2.0, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                            TextFormField(
                              controller: txt_birthDate,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                              labelText: "Tanggal Lahir",
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 2.0, color: Colors.grey)
                            ),
                            prefixIcon: IconButton(
                              icon: Icon(Icons.calendar_month),
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                            labelStyle: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                              BorderSide(width: 2.0, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 42,
                          width: MediaQuery.of(context).size.width - 2 * 20,
                          child: ElevatedButton(
                            onPressed: () {
                              //
                            },
                            child: Text(
                              'Ubah',
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
                  )
                ],
              ),
            ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
