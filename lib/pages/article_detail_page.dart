import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const ArticleDetailPage({
    Key? key,
    required this.title,
    required this.content,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 3 / 3, //ukurannya jadi 3:3
                child: Image.network(
                  imageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/default_image.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                content,
                textAlign: TextAlign.justify, //rata kanan kiri ini
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
