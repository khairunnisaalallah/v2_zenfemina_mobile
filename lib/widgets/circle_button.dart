import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CircleButton({Key? key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.5),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ));
  }
}
