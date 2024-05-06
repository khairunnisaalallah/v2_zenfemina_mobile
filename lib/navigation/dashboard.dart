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

  // final List<String> cities = [
  //   'Jember',
  //   'Ambulu',
  //   'Kaliwates',
  //   'Sumberbaru',
  //   'Sukorambi',
  //   'Wuluhan',
  //   'Puger',
  //   'Arjasa',
  //   'Panti',
  //   'Ajung'
  // ];

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
                    // DropdownButton<String>(
                    //   icon: Icon(Icons.arrow_drop_down,
                    //       color: Colors.white), // Icon berwarna putih
                    //   hint: Text(
                    //     'Pilih Kota',
                    //     style: TextStyle(
                    //         color: Colors.white), // Set teks warna putih
                    //   ), // Hints untuk menampilkan pesan sebelum pilihan dibuat
                    //   value: _selectedCity, // Nilai awal dropdown
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       _selectedCity =
                    //           newValue; // Memperbarui nilai kota yang dipilih
                    //     });
                    //   },
                    //   items:
                    //       cities.map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(
                    //         value,
                    //         style: TextStyle(
                    //             color: _selectedCity == value
                    //                 ? Colors
                    //                     .white // Warna teks putih jika dipilih
                    //                 : Colors
                    //                     .black), // Ubah warna teks menjadi hitam
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                    SizedBox(height: 30), // Spasi antara dropdown dan teks
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
              //ini buat containernya
              Positioned(
                top: 180,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 325,
                    height: 200, // Menyesuaikan dengan penambahan tombol
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '14 September 2024',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color(0XFFDA4256),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5), // Spacer
                        Text(
                          '9 Hari Lagi',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            color: Color(0xFFDA4256),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5), // Spacer
                        Text(
                          'Menuju siklus selanjutnya',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color(0xFFDA4256),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20), // Spacer
                        ElevatedButton(
                          onPressed: () {
                            // Tambahkan logika yang ingin dijalankan saat tombol ditekan
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFFDA4256),
                            backgroundColor: Colors.white,
                            elevation: 5, // Tambahkan efek shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: Color(0xFFDA4256), width: 2),
                            ),
                            minimumSize: Size(132, 35), // Ukuran tombol
                          ),
                          child: Text(
                            'Awali Menstruasi',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Color(0xFFDA4256),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 400,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 30), // Jarak dari tepi layar
                        Text(
                          'Menu Lainnya',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Spasi antara teks dan container
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 92,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 45), // Penurunan posisi
                              child: Text(
                                'Hutang Sholat',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20), // Spasi antara kedua container
                        Container(
                          width: 160,
                          height: 92,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 45), // Penurunan posisi
                              child: Text(
                                'Hutang Puasa',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

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

  Container ContainerWidget() {
    return Container(
      width: 340,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), // perubahan posisi bayangan jika diperlukan
          ),
        ],
      ),
    );
  }
}
