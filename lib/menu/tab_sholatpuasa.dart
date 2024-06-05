import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zenfemina_v2/api_repository.dart';
import 'package:intl/intl.dart';

class Tabsholatpuasa extends StatefulWidget {
  const Tabsholatpuasa({Key? key}) : super(key: key);

  @override
  _TabsholatpuasaState createState() => _TabsholatpuasaState();
}

class _TabsholatpuasaState extends State<Tabsholatpuasa> {
  final ApiRepository _apiRepository = ApiRepository();
  String? _details = '';
  String _date = '';
  bool subuhChecked = false;
  bool haidChecked = false;

  List<Map<String, dynamic>> _prayingDebts = [];
  List<Map<String, dynamic>> _completedPrayingDebts = [];
  List<Map<String, dynamic>> _fastingDebts = [];

  @override
  void initState() {
    super.initState();
    _fetchPrayingDebts();
    _fetchFastingDebts();
  }

  Future<void> _fetchPrayingDebts() async {
    try {
      ApiRepository apiRepository = ApiRepository();
      List<Map<String, dynamic>> debts = await apiRepository.getPrayingDebts();
      if (debts.isNotEmpty) {
        setState(() {
          _prayingDebts = debts;
          _details = _prayingDebts[0]['details'];
          _date = _prayingDebts[0]['date'];
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchFastingDebts() async {
    try {
      ApiRepository apiRepository = ApiRepository();
      List<Map<String, dynamic>> debts = await apiRepository.getFastingDebts();
      if (debts.isNotEmpty) {
        setState(() {
          _fastingDebts = debts;
          _details = _fastingDebts[0]['details'];
          _date = _fastingDebts[0]['date'];
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updateDebtAndMove(int debtId) async {
    try {
      await _apiRepository.updatePrayingDebt(debtId);
      setState(() {
        _prayingDebts.removeWhere((debt) => debt['id'] == debtId);
        _completedPrayingDebts
            .add(_prayingDebts.firstWhere((debt) => debt['id'] == debtId));
      });
    } catch (e) {
      print('Error: $e');
    }
  }

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
                            buildCompletedSholatList(),
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
                          color: Color(0xFFDA4256).withOpacity(0.20),
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

  Widget buildSholatCheckbox(String sholatName, bool isChecked,
      void Function(bool?) onChanged, int debtId) {
    return GestureDetector(
      onTap: () {
        showConfirmationDialog(isChecked, onChanged, debtId);
      },
      child: Container(
        height: 60,
        width: 330,
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
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
                      _prayingDebts.isNotEmpty
                          ? DateFormat('yyyy.MM.dd')
                              .format(DateTime.parse(_prayingDebts[0]['date']))
                          : 'Tanggal tidak tersedia',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                showConfirmationDialog(isChecked, onChanged, debtId);
              },
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
      ),
    );
  }

  Widget buildSholatList() {
    return Padding(
      padding: const EdgeInsets.only(top: 30), // Menambahkan padding di sini
      child: ListView(
        children: _prayingDebts.map((debt) {
          return buildSholatCheckbox(
            'Sholat ${debt['details']}',
            subuhChecked,
            (bool? value) {
              setState(() {
                subuhChecked = value ?? false;
              });
            },
            debt['id'],
          );
        }).toList(),
      ),
    );
  }

  Widget buildCompletedSholatList() {
    return Padding(
      padding: const EdgeInsets.only(top: 30), // Menambahkan padding di sini
      child: ListView(
        children: _completedPrayingDebts.map((debt) {
          return buildSholatCheckbox(
            'Sholat ${debt['details']}',
            true,
            (bool? value) {},
            debt['id'],
          );
        }).toList(),
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
        ],
      ),
    );
  }

  void showConfirmationDialog(
      bool isChecked, void Function(bool?) onChanged, int debtId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          content: Container(
            width: 306,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'Apakah anda sudah sholat?',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          onChanged(true);
                        });
                        _updateDebtAndMove(debtId);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFFDA4256),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color(0xFFDA4256)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Sudah',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFDA4256),
                        side: BorderSide(color: Color(0xFFDA4256)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Belum',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
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
