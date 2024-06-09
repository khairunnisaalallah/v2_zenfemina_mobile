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

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final ApiRepository _apiRepository = ApiRepository();
  String? _username = '';
  bool _isLoading = true;
  late CarouselController controller = CarouselController();
  int currentIndex = 0;
  int indexCategory = 0;
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> _articles = [];
  List<dynamic> _filteredArticles = [];
  List<dynamic> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _loadUserInfo();
    _loadCategories();
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await _apiRepository.getUserInfo();
      final username = userInfo['data']['username'];

      setState(() {
        _username = username;
      });
    } catch (e) {
      print('Failed to load user info: $e');
    }
  }

  Future<void> _loadArticles() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final articles = await _apiRepository.getArticles();
      setState(() {
        _articles = articles;
        _filteredArticles = articles; // Awalnya menampilkan semua artikel
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load articles: $e');
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load articles. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _loadArticles();
                },
                child: Text('Retry'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _apiRepository.getCategories();
      categories.insert(0, {"id": -1, "name": "Semua"});
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print('Failed to load categories: $e');
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<void> _loadArticlesByCategory(int categoryId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final articles = await _apiRepository.getArticlesByCategory(categoryId);
      setState(() {
        _articles = articles;
        _filteredArticles = articles; // Update filtered articles
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load articles by category: $e');
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Maaf artikel dengan kategori ini sedang tidak ada, coba lagi nanti.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _loadArticlesByCategory(categoryId);
                },
                child: Text('Retry'),
              ),
            ],
          );
        },
      );
    }
  }

  void _searchArticles(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredArticles = _articles;
      } else {
        _filteredArticles = _articles
            .where((article) =>
                article['title'].toLowerCase().contains(query.toLowerCase()) ||
                article['content'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
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
              top: 63,
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
                    SizedBox(height: 4),
                    Text(
                      'Temukan artikel yang sesuai untukmu',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 400,
                      height: 46,
                      decoration: BoxDecoration(
                        color: TColor.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Pencarian ...',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    bottom: 5), // Mengatur padding bawah
                              ),
                              onChanged: (value) {
                                _searchArticles(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   top: 35,
            //   right: 25,
            //   child: Row(
            //     children: [
            //       SizedBox(width: 240),
            //       CircleButton(
            //         icon: Icons.person_2_outlined,
            //         onPressed: () {},
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _filteredArticles.isEmpty
              ? Center(child: Text('Article Belum Dibuat'))
              : RefreshIndicator(
                  onRefresh: _loadArticles,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
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
                          items: _filteredArticles
                              .map((article) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ArticleDetailPage(
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
                          count: _filteredArticles.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor: Color(0xFFDA4256),
                            dotHeight: 10,
                            dotWidth: 10,
                          ),
                        ),
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
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                              height: 30,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _categories.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  final category = _categories[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexCategory = index;
                                      });
                                      if (index == 0) {
                                        _loadArticles(); // Memuat semua artikel
                                      } else {
                                        _loadArticlesByCategory(category['id']);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.only(
                                        bottom: 5,
                                        top: 5,
                                        left: 15,
                                        right: 15,
                                      ),
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
                                          category['name'],
                                          style: GoogleFonts.poppins(
                                            color: indexCategory == index
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
                        ),
                        SizedBox(height: 7),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: _filteredArticles.length,
                            itemBuilder: (BuildContext context, int index) {
                              final article = _filteredArticles[index];
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
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 115,
                                  margin: EdgeInsets.only(top: 8),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xFFE0E0E0)),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          'https://v2.zenfemina.com/storage/' +
                                              article['image'],
                                          width: 120,
                                          height: 100,
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
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 2,
                                            ),
                                            SizedBox(height: 4),
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
                  ),
                ),
    );
  }
}
