import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfemina_v2/pages/question2.dart';
import 'package:zenfemina_v2/pages/question3.dart';
import 'package:zenfemina_v2/shared/shared.dart';

class QuestionTambahan extends StatefulWidget {
  const QuestionTambahan({Key? key}); //constructor

  @override
  _QuestionTambahanState createState() => _QuestionTambahanState();
}

class _QuestionTambahanState extends State<QuestionTambahan> {  
  String? is_holy;
  final String _preferenceKey = 'is_holy';

  @override
  void initState() {
    super.initState();
    _loadIsHoly();
  }

  Future<void> _loadIsHoly() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      is_holy = prefs.getString(_preferenceKey);
    });
  }

  Future<void> _setIsHoly(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_preferenceKey, value);
    setState(() {
      is_holy = value;
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
                'assets/images/question3.png',
                height: 270,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Apakah saat ini anda dalam keadaan suci?',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 0),
            Text(
              'Suci artinya kamu tidak sedang menstruasi atau sedang haid',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30),
            RadioMenuButton(
              value: '1', 
              groupValue: is_holy, 
              onChanged: (value) {
                _setIsHoly(value!);
              },
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Colors.grey, 
                      width: 1.0,
                    ),
                  )
                ),
                elevation: const MaterialStatePropertyAll(2),
                backgroundColor: const MaterialStatePropertyAll(Colors.white)
              ),
              child: const Text('Iya'),
            ),
            SizedBox(height: 10),
            RadioMenuButton(
              value: '0', 
              groupValue: is_holy, 
              onChanged: (value) {
                _setIsHoly(value!);
              },
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Colors.grey, 
                      width: 1.0,
                    ),
                  )
                ),
                elevation: const MaterialStatePropertyAll(2),
                backgroundColor: const MaterialStatePropertyAll(Colors.white)
              ),
              child: const Text('Tidak'),
            ),
            SizedBox(height: 30),
            Container(
              height: 42,
              width: MediaQuery.of(context).size.width -
                  2 * 20, // Sesuaikan dengan padding yang diinginkan
              child: ElevatedButton(
                onPressed: (){
                  Get.to(Question2Page());
                },
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