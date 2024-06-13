import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPw extends StatefulWidget {
  const EditPw({Key? key}) : super(key: key);

  @override
  State<EditPw> createState() => _EditPwState();
}

class _EditPwState extends State<EditPw> {
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
          'Ubah Kata Sandi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 0, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Kata sandi baru",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(width: 2.0, color: Colors.grey)),
                        prefixIcon: Icon(
                          Icons
                              .key_outlined, // Mengubah ikon email menjadi ikon kunci
                          color: Colors.grey,
                        ),
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
                    SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Ulangi Kata Sandi",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(width: 2.0, color: Colors.grey)),
                        prefixIcon: Icon(
                          Icons
                              .key_outlined, // Mengubah ikon email menjadi ikon kunci
                          color: Colors.grey,
                        ),
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
