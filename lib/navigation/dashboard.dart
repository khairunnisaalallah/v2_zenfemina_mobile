import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/menu/calender.dart';
import 'package:zenfemina_v2/widgets/circle_button.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _selectedCity; // variabel untuk menyimpan kota yang dipilih

  final List<String> cities = [
    'Jember',
    'Ambulu',
    'Kaliwates',
    'Sumberbaru',
    'Sukorambi',
    'Wuluhan',
    'Puger',
    'Arjasa',
    'Panti',
    'Ajung'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context)
              .size
              .height, // Sesuaikan tinggi dengan tinggi layar
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 259,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Color(0xFFDA4256),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
              // yg merah2 itu
              Positioned(
                top: 45,
                left: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.white), // Icon berwarna putih
                      hint: Text(
                        'Pilih Kota',
                        style: TextStyle(
                            color: Colors.white), // Set teks warna putih
                      ), // Hints untuk menampilkan pesan sebelum pilihan dibuat
                      value: _selectedCity, // Nilai awal dropdown
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCity =
                              newValue; // Memperbarui nilai kota yang dipilih
                        });
                      },
                      items:
                          cities.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: _selectedCity == value
                                    ? Colors
                                        .white // Warna teks putih jika dipilih
                                    : Colors
                                        .black), // Ubah warna teks menjadi hitam
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10), // Spasi antara dropdown dan teks
                    Text(
                      'Hello',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Ayo mulai atur siklus haidmu !',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 25,
                child: Row(
                  children: [
                    SizedBox(width: 210),
                    CircleButton(
                      icon: Icons.calendar_month,
                      onPressed: () {
                        Get.to(calenderPage());
                      },
                    ),
                    SizedBox(width: 5),
                    CircleButton(
                      icon: Icons.notifications,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: Center(
                  child: CardWidget(),
                ),
              ),
              Positioned(
                  top: 450,
                  right: 210,
                  left: 0,
                  child: Center(
                      child: Text(
                    'Menu Lainnya',
                    style: GoogleFonts.outfit(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ))),
              Positioned(
                  top: 570,
                  right: 190,
                  left: 0,
                  child: Center(
                      child: Text(
                    'Informasi Terkait',
                    style: GoogleFonts.outfit(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget CardWidget() {
    return SizedBox(
      width: 340,
      height: 90,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black.withOpacity(1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
