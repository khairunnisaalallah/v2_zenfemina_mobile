import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/pages/home.dart';
import 'package:zenfemina_v2/shared/shared.dart';

class question4Page extends StatefulWidget {
  const question4Page({Key? key}); //constructor

  @override
  _question4PageState createState() => _question4PageState();
}

class _question4PageState extends State<question4Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 100),
              child: Image.asset(
                'assets/images/question4.png',
                height: 280,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Berapa lama biasanya waktu haid anda berlangsung?',
              textAlign: TextAlign.left,
              style: GoogleFonts.outfit(
                  fontSize: 25, color: greyColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 0),
            Text(
              'Biasanya berlangsung selama 5-6 hari atau lebih.',
              textAlign: TextAlign.left,
              style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30),
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Lama Haid",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    labelStyle: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(12.0)),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ))),
            SizedBox(height: 30),
            Container(
              height: 42,
              width: MediaQuery.of(context).size.width -
                  2 * 20, // Sesuaikan dengan padding yang diinginkan
              child: ElevatedButton(
                onPressed: () {
                  Get.to(home());
                },
                child: Text(
                  'Selanjutnya',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
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
            )
          ],
        ),
      ),
    );
  }
}
