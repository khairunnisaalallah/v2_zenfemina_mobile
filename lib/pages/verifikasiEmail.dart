import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class verifikasiEmail extends StatefulWidget {
  const verifikasiEmail({Key? key}) : super(key: key);

  @override
  State<verifikasiEmail> createState() => _verifikasiEmailState();
}

class _verifikasiEmailState extends State<verifikasiEmail> {
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Atur Ulang Kata Sandi',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 0),
                child: Text(
                  'Masukkan e-mail yang terdaftar. Kami akan mengirimkan kode verifikasi untuk atur ulang kata sandi',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(height: 25),
              //Expanded(
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding:
                    //const EdgeInsets.symmetric(vertical: 0, horizontal: 5, ),
                    const EdgeInsets.only(top: 5, left: 0, right: 20),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.grey,
                          ),
                          labelStyle: GoogleFonts.poppins(
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
                      SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 0, left: 0, right: 0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Kirim kode verifikasi',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFDA4256),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
