import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/pages/question2.dart';
import 'package:zenfemina_v2/shared/shared.dart';
import 'package:intl/intl.dart';

class question1Page extends StatefulWidget {
  const question1Page({Key? key}); //constructor

  @override
  _question1PageState createState() => _question1PageState();
}

class _question1PageState extends State<question1Page> {
  TextEditingController _dateController = TextEditingController();
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
                'assets/images/question1.png',
                height: 290,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Kapan Kamu Lahir ?',
              textAlign: TextAlign.left,
              style: GoogleFonts.outfit(
                  fontSize: 30, color: greyColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 0),
            Text(
              'Silahkan isi tanggal, bulan, dan tahun kelahiran anda',
              textAlign: TextAlign.left,
              style: GoogleFonts.outfit(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 30),
            TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                    labelText: "Tanggal lahir anda",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    labelStyle: GoogleFonts.outfit(
                        fontSize: 15,
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
                    MaterialPageRoute(builder: (context) => question2Page()),
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
