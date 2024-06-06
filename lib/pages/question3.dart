import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import ini diperlukan untuk inputFormatters
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfemina_v2/pages/question4.dart';
import 'package:zenfemina_v2/shared/shared.dart';

class Question3Page extends StatefulWidget {
  const Question3Page({Key? key}); //constructor

  @override
  _Question3PageState createState() => _Question3PageState();
}

class _Question3PageState extends State<Question3Page> {
  TextEditingController _cycleController = TextEditingController();
  bool _isCycleEntered = false;

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
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 0),
            Text(
              'Misalkan, siklus haid saya biasanya berlangsung selama 28-30 hari.',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _cycleController,
              decoration: InputDecoration(
                labelText: "Lama siklus",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 18,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              onChanged: (value) {
                setState(() {
                  _isCycleEntered = value
                      .isNotEmpty; // Tandai bahwa lama siklus sudah dimasukkan jika nilai tidak kosong
                });
              },
            ),
            SizedBox(height: 30),
            Container(
              height: 42,
              width: MediaQuery.of(context).size.width -
                  2 * 20, // Sesuaikan dengan padding yang diinginkan
              child: ElevatedButton(
                onPressed: _isCycleEntered
                    ? () async {
                        final cycle = _cycleController.text;
                        if (cycle.isEmpty) {
                          print('Cycle is empty');
                          return;
                        }
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('cycle', cycle);
                        Get.to(Question4Page());
                      }
                    : null,
                child: Text(
                  'Selanjutnya',
                  style: GoogleFonts.poppins(
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
            ),
          ],
        ),
      ),
    );
  }
}
