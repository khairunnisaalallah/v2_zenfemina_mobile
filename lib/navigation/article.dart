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

class _articlePageState extends State<articlePage> {
  late CarouselController controller = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(220),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 220,
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

      body: Column(
        children: [
          SizedBox(height: 25),
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
          )
        ],
      )

      // Center(
      //   child: Container(
      //     constraints: const BoxConstraints(maxWidth: 400),
      //     child: ListView.builder(
      //       itemCount: _articles.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         final item = _articles[index];
      //         return Container(
      //           height: 136,
      //           margin:
      //               const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      //           decoration: BoxDecoration(
      //               border: Border.all(color: const Color(0xFFE0E0E0)),
      //               borderRadius: BorderRadius.circular(8.0)),
      //           padding: const EdgeInsets.all(8),
      //           child: Row(
      //             children: [
      //               Expanded(
      //                   child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     item.title,
      //                     style: const TextStyle(fontWeight: FontWeight.bold),
      //                     maxLines: 2,
      //                     overflow: TextOverflow.ellipsis,
      //                   ),
      //                   const SizedBox(height: 8),
      //                   Text("${item.author} · ${item.postedOn}",
      //                       style: Theme.of(context).textTheme.caption),
      //                   const SizedBox(height: 8),
      //                   Row(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       Icons.bookmark_border_rounded,
      //                       Icons.share,
      //                       Icons.more_vert
      //                     ].map((e) {
      //                       return InkWell(
      //                         onTap: () {},
      //                         child: Padding(
      //                           padding: const EdgeInsets.only(right: 8.0),
      //                           child: Icon(e, size: 16),
      //                         ),
      //                       );
      //                     }).toList(),
      //                   )
      //                 ],
      //               )),
      //               Container(
      //                   width: 100,
      //                   height: 100,
      //                   decoration: BoxDecoration(
      //                       color: Colors.grey,
      //                       borderRadius: BorderRadius.circular(8.0),
      //                       image: DecorationImage(
      //                         fit: BoxFit.cover,
      //                         image: NetworkImage(item.imageUrl),
      //                       ))),
      //             ],
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ),
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

