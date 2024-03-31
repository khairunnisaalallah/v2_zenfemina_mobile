import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    Key? key,
    required this.color,
    required this.value,
    required this.controller,
    required this.width,
    required this.height,
    required this.strokeWidth,
    this.curve = Curves.linear,
  }) : super(key: key);

  final Color color;
  final double value;
  final AnimationController controller;
  final double width;
  final double height;
  final double strokeWidth;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color,
          backgroundColor: color.withOpacity(.2),
          value: value,
        ),
      ),
    );
  }
}
