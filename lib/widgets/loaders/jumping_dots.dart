import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/color.dart';

class ThreeDotsLoader extends StatefulWidget {
  const ThreeDotsLoader({super.key});

  @override
  State<ThreeDotsLoader> createState() => _ThreeDotsLoaderState();
}

class _ThreeDotsLoaderState extends State<ThreeDotsLoader> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0)
                  .animate(CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  index * 0.2,
                  1.0,
                  curve: Curves.easeInOut,
                ),
              )),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Dot(),
              ),
            );
          }),
        );
      },
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.0,
      height: 5.0,
      decoration: BoxDecoration(
        color: black,
        shape: BoxShape.circle,
      ),
    );
  }
}
