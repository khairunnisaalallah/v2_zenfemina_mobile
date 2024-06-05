import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import ini diperlukan untuk inputFormatters
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfemina_v2/api_repository.dart';
import 'package:zenfemina_v2/pages/home.dart';
import 'package:zenfemina_v2/shared/shared.dart';

class Question4Page extends StatefulWidget {
  const Question4Page({Key? key}); //constructor

  @override
  _Question4PageState createState() => _Question4PageState();
}

class _Question4PageState extends State<Question4Page> {
  TextEditingController _periodController = TextEditingController();

  Future<void> _submitData() async {
    // Ambil data dari shared preferences
    final prefs = await SharedPreferences.getInstance();
    final birthDate = prefs.getString('birthDate') ?? '';
    final lastDate = prefs.getString('lastDate') ?? '';
    final cycle = prefs.getString('cycle') ?? '';
    final is_holy = prefs.getString('is_holy') ?? '';

    // Ambil data dari TextEditingController
    final period = _periodController.text;
    if (period.isEmpty) {
      print('Period is empty');
      return;
    }


    // Panggil API untuk mengirim data
    try {
      final api = ApiRepository();
      await api.postQuestions(birthDate, lastDate, period, cycle, is_holy);
      print('Data berhasil dikirim ke API');
    } catch (e) {
      print('Gagal mengirim data: $e');
    }
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
              style: GoogleFonts.poppins(
                fontSize: 23,
                color: greyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 0),
            Text(
              'Biasanya berlangsung selama 5-8 hari atau lebih.',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _periodController,
              decoration: InputDecoration(
                labelText: "Lama Haid",
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
                  horizontal: 20,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 42,
              width: MediaQuery.of(context).size.width -
                  2 * 20, // Sesuaikan dengan padding yang diinginkan
              child: ElevatedButton(
                onPressed: () async {
                  // Simpan data ke SharedPreferences sebelum mengirim ke API
                  final period = _periodController.text;
                  if (period.isEmpty) {
                    print('Period is empty');
                    return;
                  }
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('period', period);

                  // Kirim data ke API
                  await _submitData();

                  // Tampilkan SnackBar hijau
                  Get.snackbar(
                    'Sukses',
                    'Data berhasil di input',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );

                  // Pindah ke halaman berikutnya
                  Get.to(() => home());
                },
                child: Text(
                  'Submit',
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
