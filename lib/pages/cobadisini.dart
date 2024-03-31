import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  double percent = 0.0;

  // ** Addition in @mmcdon20 code - Start

  changePercent() {
    // 20 frame is enough to beat eye, that's why I used
    // 50 refresh/second to keep animation smooth
    Future.delayed(
      const Duration(milliseconds: 20), // Adjust accordingly.
      () {
        setState(() {
          percent += 0.005; // Adjust accordingly.
        });
        print('........................');
        if (percent < 1) {
          changePercent();
        }
      },
    );
  }
  // ** Addition in @mmcdon20 code - End

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..animateTo(1)
      ..repeat();

    // ** Addition in @mmcdon20 code - Start
    changePercent();
    // ** Addition in @mmcdon20 code - End
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomProgressIndicator(
            value: percent,
            color: Colors.orange,
            controller: controller,
            width: 200,
            height: 200,
            strokeWidth: 8,
          )
          // ** Eliminationated from @mmcdon20 code - End
        ],
      ),
    );
  }
}

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
