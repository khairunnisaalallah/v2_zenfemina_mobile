// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenfemina_v2/widgets/circle_button.dart';
import 'package:zenfemina_v2/widgets/color_extension.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class articlePage extends StatefulWidget {
  const articlePage({Key? key}) : super(key: key);

  @override
  State<articlePage> createState() => _articlePageState();
}
// final List<String> categories = <String>['Haid', 'Puasa', 'Istihadhah', 'Kesehatan', 'Sholat'];

class _articlePageState extends State<articlePage> {
  late CarouselController controller = CarouselController();
  int currentIndex = 0;
  int indexCategory = 0;
  final List<String> categories = <String>['Haid', 'Puasa', 'Istihadhah', 'Kesehatan', 'sholat', 'wanita', 'kebersihan'];
  final List<String> article = <String>['Apa itu Haid', 'Apa itu puasa', 'Apa itu sholat', 'kewajiban sholat'];


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
                height: 200,
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
              top: 30,
              left: 25,
              right: 25,
              child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hai Nisa !!',
                      style: GoogleFonts.outfit(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 60,
                      child: Text(
                        'Temukan Edukasi yang sesuai dengan permasalahan Anda',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      width: 400,
                      height: 46,
                      decoration: BoxDecoration(
                        color: TColor.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white)
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 10),
                          Text(
                            'Cari Edukasi ...',
                            style: GoogleFonts.outfit(
                              color: Colors.grey[700]
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 25,
              child: Row(
              children: [
                SizedBox(width: 230),
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

      body: SingleChildScrollView(
        child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            alignment: Alignment.topLeft, 
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Trending Artikel',
              textAlign: TextAlign.left, 
              style: GoogleFonts.outfit(
                color: Colors.grey[900],
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
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
              }
            ),
            items: [
                "assets/images/Gambar-Kartun-Muslimah-Hijab-Berkacamata-1.jpg", // Lokasi gambar di dalam proyek Flutter Anda
                "assets/images/Gambar-Kartun-Muslimah-Hijab-Imut-1.jpg",
                "assets/images/Niqab_Sastra-Arab-UI.jpg",
                "assets/images/Gambar-Kartun-Muslimah-Hijab-Berkacamata-1.jpg",
              ].map((item) => Container(
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                      item, 
                      fit: BoxFit.cover, 
                      width: 1000,
                    ),
                )
              )).toList(),
          ),
          SizedBox(height: 10),
          AnimatedSmoothIndicator(
            activeIndex: currentIndex,  
            count: 4,  
            effect:  ExpandingDotsEffect(
              activeDotColor: Color(0xFFDA4256),
              dotHeight: 10,
              dotWidth: 10
            )    
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.topLeft, 
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Direkomendasikan',
              textAlign: TextAlign.left, 
              style: GoogleFonts.outfit(
                color: Colors.grey[900],
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          SizedBox(height: 7),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20), // Sesuaikan dengan ukuran margin yang Anda inginkan
            child: SizedBox(
            height: 30,
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: (){
                  setState(() {
                    indexCategory = index; // Perbarui indexCategory ketika item dipilih
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.only(bottom: 5, top: 5, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: indexCategory == index ? Color(0xFFDA4256) : Colors.white,
                    border: Border.all(
                      color: indexCategory == index ? Color(0xFFDA4256): Color(0xFFE0E0E0),
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(child: Text(
                    categories[index],
                    style: GoogleFonts.outfit(
                      color : indexCategory == index ? Colors.white: Colors.black
                    ),
                    )),
                ),
              );
            },
          )
          ,
          )),
         SizedBox(height: 7),
         //artikel yg dibawah
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
              padding: EdgeInsets.zero, 
              shrinkWrap: true,
              itemCount: article.length,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    // do something here
                  },
                  child: Container(
                    height: 110,
                    margin: EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.only(bottom: 0, top: 0, left: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFE0E0E0),
                      ),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12), 
                            bottomLeft: Radius.circular(12)
                          ),
                          child: Image.asset(
                          "assets/images/Gambar-Kartun-Muslimah-Hijab-Imut-1.jpg",
                          width: 148,
                          height: 110,
                          fit: BoxFit.fill
                        ),
                        ),
                        SizedBox(width:10),
                        Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                              width: 180,
                              child: Text(
                                'Apa itu Haid?',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  color: Colors.black
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 180,
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vehicula....',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color : Colors.grey
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
            ),
          ),
          SizedBox(height: 20)
        ],
      )
,
      ) 
    );
  }

}

class Article {
  final String title;
  final String imageUrl;
  final String author;
  final String postedOn;

  Article(
      {required this.title,
      required this.imageUrl,
      required this.author,
      required this.postedOn});
}

final List<Article> _articles = [
  Article(
    title: "Instagram quietly limits ‘daily time limit’ option",
    author: "MacRumors",
    imageUrl:
        "https://th.bing.com/th/id/OIP.Qqix8Rm5Q4r-GVqqi9myDAHaEf?rs=1&pid=ImgDetMain", // URL baru
    postedOn: "Yesterday",
  ),
  Article(
      title: "Google Search dark theme goes fully black for some on the web",
      imageUrl:
          "https://th.bing.com/th/id/OIP.D-Ohd4cZYoFO-wS4jfErWwHaHa?w=1200&h=1200&rs=1&pid=ImgDetMain", // URL baru
      author: "9to5Google",
      postedOn: "4 hours ago"),
  // Artikel lainnya dengan URL baru
  Article(
    title: "Check your iPhone now: warning signs someone is spying on you",
    author: "New York Times",
    imageUrl: "https://picsum.photos/id/1001/960/540",
    postedOn: "2 days ago",
  ),
  Article(
    title:
        "Amazon’s incredibly popular Lost Ark MMO is ‘at capacity’ in central Europe",
    author: "MacRumors",
    imageUrl: "https://picsum.photos/id/1002/960/540",
    postedOn: "22 hours ago",
  ),
];

