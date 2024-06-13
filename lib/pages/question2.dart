import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfemina_v2/pages/question3.dart';
import 'package:zenfemina_v2/shared/shared.dart';
import 'package:intl/intl.dart';

class Question2Page extends StatefulWidget {
  const Question2Page({Key? key}); //constructor

  @override
  _Question2PageState createState() => _Question2PageState();
}

class _Question2PageState extends State<Question2Page> {
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool _isDateSelected = false;
  String is_holy = '0';
  String question = 'Sejak kapan anda haid / menstruasi?';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    is_holy = prefs.getString('is_holy') ?? '';

    setState(() {
      if (is_holy == '1') {
        question = 'Kapan terakhir anda haid?';
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate.subtract(Duration(days: 60)),
        lastDate: DateTime.now(),
        helpText: 'Pilih tanggal terakhir haid anda!');
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
                'assets/images/question2.png',
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 40),
            Text(
              question,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 0),
            Text(
              'Silahkan isi tanggal, bulan, dan tahun terakhir anda mengalami haid',
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
                  labelText: "Tanggal haid terakhir",
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
                  return 'Tanggal haid tidak boleh kosong';
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
                        //
                        // Simpan data tanggal lahir ke SharedPreferences
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('lastDate', _dateController.text);

                        // Pindah ke halaman berikutnya
                        Get.to(() => Question3Page(),
                            transition: Transition.fade);
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
