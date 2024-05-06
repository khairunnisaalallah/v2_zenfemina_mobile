import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart'; // tambahkan ini untuk menggunakan GetX

class Tabsholatpuasa extends StatelessWidget {
  const Tabsholatpuasa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  // Tambahkan fungsi untuk kembali di sini
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
                iconSize: 25, // Icon kembali
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Hutang shalat dan puasa', // Tambahkan judul "Catatan" di sini
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Color(0xFFDA4256),
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'Sholat', // Tambahkan teks "Hutang Sholat" di sini
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Puasa',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Konten untuk tab pertama
            Padding(
              padding:
                  const EdgeInsets.only(top: 26), // Tambahkan padding di sini
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  body: Column(
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFFDA4256).withOpacity(0.30),
                        ),
                        child: const TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: Color(0xFFDA4256),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black54,
                          tabs: [
                            Tab(
                              text: 'Belum Lunas',
                            ),
                            Tab(
                              text: 'Lunas',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Konten untuk sub-tab "Sub Tiga"
                            Center(child: Text('Belum Lunas Page 1')),
                            // Konten untuk sub-tab "Sub Empat"
                            Center(child: Text('Lunas Page 1')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Konten untuk tab kedua
            Padding(
              padding:
                  const EdgeInsets.only(top: 26), // Tambahkan padding di sini
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  body: Column(
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFFDA4256).withOpacity(0.30),
                        ),
                        child: const TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: Color(0xFFDA4256),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black54,
                          tabs: [
                            Tab(
                              text: 'Belum Lunas',
                            ),
                            Tab(
                              text: 'Lunas',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Konten untuk sub-tab "Sub Tiga"
                            Center(child: Text('Belum Lunas Page 2')),
                            // Konten untuk sub-tab "Sub Empat"
                            Center(child: Text('Lunas Page 2')),
                          ],
                        ),
                      ),
                    ],
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
