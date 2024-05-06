import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tabsholatpuasa extends StatelessWidget {
  const Tabsholatpuasa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Color(0xFFDA4256),
            labelColor: Colors.black, // Warna teks untuk tab terpilih
            // unselectedLabelColor:
            //     Colors.black, // Warna teks untuk tab yang tidak dipilih
            tabs: [
              Tab(
                child: Text(
                  'Sholat',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ), // Ganti dengan label untuk tab pertama
                ),
              ),
              Tab(
                child: Text(
                  'Puasa',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ), // Ganti dengan label untuk tab kedua
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Konten untuk tab pertama
            DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
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
                                text:
                                    'Belum Lunas'), // Ganti dengan Tab bawaan Flutter
                            Tab(
                                text:
                                    'Lunas'), // Ganti dengan Tab bawaan Flutter
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                body: const TabBarView(
                  children: [
                    Center(child: Text('Belum Lunas Page 1')),
                    Center(child: Text('Lunas Page 1')),
                  ],
                ),
              ),
            ),
            // Konten untuk tab kedua
            DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        height: 40,
                        // width: 230,
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
                                text:
                                    'Belum Lunas'), // Ganti dengan label untuk sub-tab ketiga
                            Tab(
                                text:
                                    'Lunas'), // Ganti dengan label untuk sub-tab keempat
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    // Konten untuk sub-tab "Sub Tiga"
                    Center(child: Text('Belum Lunas Page 2')),
                    // Konten untuk sub-tab "Sub Empat"
                    Center(child: Text('Lunas Page 2')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
