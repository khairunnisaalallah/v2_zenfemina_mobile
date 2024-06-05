//ITU YANG GAMBAR DI REKOMENDASIKAN ARTICLE MASI AD YG EROR MAKANNYA KUJADIKAN COMMENT YANG
//BAGIAN IMAGE NYA

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/api_repository.dart';
import 'package:zenfemina_v2/pages/article_detail_page.dart';
import 'package:zenfemina_v2/widgets/circle_button.dart';
import 'package:zenfemina_v2/widgets/color_extension.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class articlePage extends StatefulWidget {
  const articlePage({Key? key}) : super(key: key);

  @override
  State<articlePage> createState() => _articlePageState();
}
// final List<String> categories = <String>['Haid', 'Puasa', 'Istihadhah', 'Kesehatan', 'Sholat'];

class _articlePageState extends State<articlePage> {
  final ApiRepository _apiRepository = ApiRepository();
  String? _username = '';
  bool _isLoading = true;
  late CarouselController controller = CarouselController();
  int currentIndex = 0;
  int indexCategory = 0;

  List<dynamic> _articles = [];
  @override
  void initState() {
    super.initState();
    _loadArticles();
    _loadUserInfo();
  }

  final List<String> categories = <String>[
    'Haid',
    'Puasa',
    'Istihadhah',
    'Kesehatan',
    'sholat',
    'wanita',
    'kebersihan'
  ];

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await _apiRepository.getUserInfo();
      final username =
          userInfo['data']['username']; // Mengambil nilai username dari respons

      setState(() {
        _username = username; // Menyimpan nilai username ke dalam _userName
      });
    } catch (e) {
      print('Failed to load user info: $e');
    }
  }

  Future<void> _loadArticles() async {
    setState(() {
      _isLoading = true; // Menampilkan indikator loading
    });

    try {
      final articles = await _apiRepository.getArticles();
      setState(() {
        _articles = articles;
        _isLoading =
            false; // Menyembunyikan indikator loading setelah artikel dimuat
      });
    } catch (e) {
      print('Failed to load articles: $e');
      setState(() {
        _isLoading = false; // Menyembunyikan indikator loading
      });

      // Menampilkan pesan kesalahan kepada pengguna
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load articles. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                  _loadArticles(); // Memuat ulang artikel
                },
                child: Text('Retry'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 210,
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
              Positioned(
                top: 50,
                left: 25,
                right: 25,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ayo $_username',
                        style: GoogleFonts.poppins(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 250,
                        height: 60,
                        child: Text(
                          'Temukan Artikel yang sesuai dengan permasalahan Anda',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 0),
                      Container(
                        width: 400,
                        height: 46,
                        decoration: BoxDecoration(
                            color: TColor.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 10),
                            Text(
                              'Cari Edukasi ...',
                              style:
                                  GoogleFonts.poppins(color: Colors.grey[700]),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 35,
                right: 25,
                child: Row(
                  children: [
                    SizedBox(width: 240),
                    CircleButton(
                      icon: Icons.person_2_outlined,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: _isLoading //loading pas memuat
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadArticles,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Trending Artikel',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              color: Colors.grey[900],
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 7),
                      CarouselSlider(
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 150,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          aspectRatio: 2.0,
                          initialPage: currentIndex,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                        items: _articles
                            .map((article) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ArticleDetailPage(
                                          title: article['title'],
                                          content: article['content'],
                                          imageUrl:
                                              'https://v2.zenfemina.com/storage/' +
                                                  article['image'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        'https://v2.zenfemina.com/storage/' +
                                            article['image'],
                                        fit: BoxFit.cover,
                                        width: 1000,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),

                      SizedBox(height: 10),
                      AnimatedSmoothIndicator(
                          activeIndex: currentIndex,
                          count: 4,
                          effect: ExpandingDotsEffect(
                              activeDotColor: Color(0xFFDA4256),
                              dotHeight: 10,
                              dotWidth: 10)),
                      SizedBox(height: 15),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Direkomendasikan',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              color: Colors.grey[900],
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 7),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 20,
                              right:
                                  20), // Sesuaikan dengan ukuran margin yang Anda inginkan
                          child: SizedBox(
                            height: 30,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: categories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      indexCategory =
                                          index; // Perbarui indexCategory ketika item dipilih
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 5, left: 15, right: 15),
                                    decoration: BoxDecoration(
                                      color: indexCategory == index
                                          ? Color(0xFFDA4256)
                                          : Colors.white,
                                      border: Border.all(
                                        color: indexCategory == index
                                            ? Color(0xFFDA4256)
                                            : Color(0xFFE0E0E0),
                                      ),
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: Center(
                                        child: Text(
                                      categories[index],
                                      style: GoogleFonts.poppins(
                                          color: indexCategory == index
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                                  ),
                                );
                              },
                            ),
                          )),
                      SizedBox(height: 7),
                      //artikel yg dibawah
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: _articles.length,
                          itemBuilder: (BuildContext context, int index) {
                            final article = _articles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleDetailPage(
                                      title: article['title'],
                                      content: article['content'],
                                      imageUrl:
                                          'https://v2.zenfemina.com/storage/' +
                                              article['image'],
                                      // // Tambahkan URL gambar di sini
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 110,
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xFFE0E0E0)),
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        'https://v2.zenfemina.com/storage/' +
                                            article['image'],
                                        width: 120,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article['title'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            article['content'],
                                            textAlign: TextAlign.justify,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )));
  }
}


//ini asli2