import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/pages/range_date.dart';
import 'package:zenfemina_v2/widgets/circle_button.dart';
import 'package:zenfemina_v2/menu/calender.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(120), // Sesuaikan tinggi sesuai kebutuhan
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 105,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 40), // Spacer untuk jarak
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Ikon akan berada di sisi kiri sudut atas
                          IconButton(
                            onPressed: () {
                              Get.back(); // Fungsi untuk kembali ke halaman sebelumnya
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),

                          Center(
                            child: Text(
                              'Kalender',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          CircleButton(
                            icon: Icons.notifications,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Transform.translate(
        offset: Offset(0, -60), // Geser widget ke atas sebanyak 20px
        child: TableRangeExample(),
      ),
      // Tambahkan widget TableRangeExample di sini
    );
  }
}
