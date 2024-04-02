import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/pages/question3.dart';
import 'package:zenfemina_v2/shared/shared.dart';
import 'package:intl/intl.dart';

class question2Page extends StatefulWidget {
  const question2Page({Key? key}); //constructor

  @override
  _question2PageState createState() => _question2PageState();
}

class _question2PageState extends State<question2Page> {
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate.subtract(Duration(days: 60)),
        lastDate: DateTime.now(),
        helpText: 'Pilih tanggal terakhir haid anda!');
    if (picked != null && picked != selectedDate)
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
  }

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
                'assets/images/question2.png',
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Kapan terakhir anda haid?',
              textAlign: TextAlign.left,
              style: GoogleFonts.outfit(
                  fontSize: 28, color: Colors.grey[800], fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 0),
            Text(
              'Silahkan isi tanggal, bulan, dan tahun terakhir anda mengalami haid',
              textAlign: TextAlign.left,
              style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30),
            TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                    labelText: "Tanggal haid terakhir",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    labelStyle: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15.0)),
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
                  Get.to(question3Page());
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
