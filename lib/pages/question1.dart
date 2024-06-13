import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfemina_v2/pages/question2.dart';
import 'package:zenfemina_v2/pages/questionTambahan.dart';
import 'package:zenfemina_v2/shared/shared.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class Question1Page extends StatefulWidget {
  const Question1Page({Key? key}); //constructor

  @override
  _Question1PageState createState() => _Question1PageState();
}

class _Question1PageState extends State<Question1Page> {
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool _isDateSelected = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1970, 1),
        lastDate: selectedDate,
        helpText: 'Pilih tanggal lahir mu!');
    if (picked != null && picked != selectedDate)
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
        _isDateSelected = true;
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
                'assets/images/question1.png',
                height: 290,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Kapan Kamu Lahir ?',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 0),
            Text(
              'Silahkan isi tanggal, bulan, dan tahun kelahiran anda',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                  labelText: "Tanggal lahir anda",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  labelStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
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
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tanggal lahir tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            Container(
              height: 42,
              width: MediaQuery.of(context).size.width -
                  2 * 20, // Sesuaikan dengan padding yang diinginkan
              child: ElevatedButton(
                onPressed: _isDateSelected
                    ? () async {
                        // Get.to(Question2Page());
                        // Simpan data tanggal lahir ke SharedPreferences
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            'birthDate', _dateController.text);

                        // Pindah ke halaman berikutnya
                        Get.to(
                          () => QuestionTambahan(),
                          transition: Transition.fade,
                        );
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
            )
          ],
        ),
      ),
    );
  }
}
