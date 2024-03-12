import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/pages/question4.dart';
import 'package:zenfemina_v2/shared/shared.dart';

class question3Page extends StatefulWidget {
  const question3Page({Key? key}); //constructor

  @override
  _question3PageState createState() => _question3PageState();
}

class _question3PageState extends State<question3Page> {
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
              margin: EdgeInsets.only(top: 115),
              child: Image.asset(
                'assets/images/question3.png',
                height: 270,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Berapa lama siklus haid anda?',
              textAlign: TextAlign.left,
              style: GoogleFonts.outfit(
                  fontSize: 25, color: greyColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 0),
            Text(
              'Misalkan, siklus haid saya biasanya berlangsung selama 28-30 hari.',
              textAlign: TextAlign.left,
              style: GoogleFonts.outfit(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 30),
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Lama siklus",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    labelStyle: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ))),
            SizedBox(height: 30),
            Container(
              height: 42,
              width: MediaQuery.of(context).size.width -
                  2 * 20, // Sesuaikan dengan padding yang diinginkan
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => question4Page()),
                  );
                },
                child: Text(
                  'Selanjutnya',
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
            )
          ],
        ),
      ),
    );
  }
}
