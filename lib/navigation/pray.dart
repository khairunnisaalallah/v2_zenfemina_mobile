import 'package:flutter/material.dart';

class prayPage extends StatelessWidget {
  const prayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pray'),
      ),
      body: Center(
        child: Text(
          'Pray Screen',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
