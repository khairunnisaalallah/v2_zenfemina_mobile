import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  bool invalidOtp = false;
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  TextEditingController txt4 = TextEditingController();
  TextEditingController txt5 = TextEditingController();

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
                'Masukkan Kode Verifikasi',
                style: GoogleFonts.outfit(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 0),
                child: Text(
                  'Kode verifikasi telah dikirim melalui e-mail ke email yang terdaftar',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                children: [
                  myInputBox(context, txt1),
                  myInputBox(context, txt2),
                  myInputBox(context, txt3),
                  myInputBox(context, txt4),
                  myInputBox(context, txt5),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 0, right:30 ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Lanjutkan',
                    style: GoogleFonts.outfit(
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
    );
  }

  Widget myInputBox(BuildContext context, TextEditingController controller) {
    return Container(
      width: 50,
      padding: EdgeInsets.symmetric(vertical: 5), // Menambah padding vertikal
     margin: EdgeInsets.only(right: 20), // Menambah margin kanan agar rata dengan tulisan "Kode Verifikasi"
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
