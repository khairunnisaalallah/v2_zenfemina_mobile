import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Tabsholatpuasa extends StatefulWidget {
  const Tabsholatpuasa({Key? key}) : super(key: key);

  @override
  _TabsholatpuasaState createState() => _TabsholatpuasaState();
}

class _TabsholatpuasaState extends State<Tabsholatpuasa> {
  bool subuhChecked = false;
  bool dhuhrChecked = false;
  bool ashrChecked = false;
  bool maghribChecked = false;
  bool ishaChecked = false;

  bool haidChecked = false;
  bool sakitChecked = false;

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
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
                iconSize: 25,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Hutang shalat dan puasa',
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
                  'Sholat',
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
              padding: const EdgeInsets.only(top: 26),
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
                            // Konten untuk sub-tab "Sholat"
                            buildSholatList(),
                            // Sholatcheck(),

                            // Konten untuk sub-tab "Sholat"
                            Center(child: Text('Lunas Page sholat')),
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
              padding: const EdgeInsets.only(top: 26),
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
                            // Konten untuk sub-tab "Puasa"
                            buildPuasaList(),
                            // Konten untuk sub-tab "Puasa"
                            Center(child: Text('Lunas Page puasa')),
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

  Widget buildSholatList() {
    return Padding(
      padding: const EdgeInsets.only(top: 30), // Menambahkan padding di sini
      child: ListView(
        children: [
          buildSholatCheckbox('Sholat Subuh', subuhChecked, (bool? value) {
            setState(() {
              subuhChecked = value ?? false;
            });
          }),
          buildSholatCheckbox('Sholat Dhuhr', dhuhrChecked, (bool? value) {
            setState(() {
              dhuhrChecked = value ?? false;
            });
          }),
          buildSholatCheckbox('Sholat Ashr', ashrChecked, (bool? value) {
            setState(() {
              ashrChecked = value ?? false;
            });
          }),
          buildSholatCheckbox('Sholat Maghrib', maghribChecked, (bool? value) {
            setState(() {
              maghribChecked = value ?? false;
            });
          }),
          buildSholatCheckbox('Sholat Isha', ishaChecked, (bool? value) {
            setState(() {
              ishaChecked = value ?? false;
            });
          }),
        ],
      ),
    );
  }

  Widget buildPuasaList() {
    return Padding(
      padding: const EdgeInsets.only(top: 30), // Menambahkan padding di sini
      child: ListView(
        children: [
          buildPuasaCheckbox('Hutang Haid', haidChecked, (bool? value) {
            setState(() {
              haidChecked = value ?? false;
            });
          }),
          buildPuasaCheckbox('Hutang Sakit', sakitChecked, (bool? value) {
            setState(() {
              sakitChecked = value ?? false;
            });
          }),
        ],
      ),
    );
  }

  Widget buildSholatCheckbox(
      String sholatName, bool isChecked, void Function(bool?) onChanged) {
    return Container(
      height: 60,
      width: 330,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white, // Mengubah warna latar belakang menjadi putih
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sholatName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2023.03.04', // Ganti dengan tanggal yang sesuai
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
            shape: CircleBorder(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.green;
                }
                return Colors.transparent;
              },
            ),
            checkColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget buildPuasaCheckbox(
      String puasaName, bool isChecked, void Function(bool?) onChanged) {
    return Container(
      height: 60,
      width: 330,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white, // Mengubah warna latar belakang menjadi putih
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    puasaName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2023.03.04', // Ganti dengan tanggal yang sesuai
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
            shape: CircleBorder(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.green;
                }
                return Colors.transparent;
              },
            ),
            checkColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
//INI ASLI