import 'package:flutter/material.dart';

class GradientBackgroundWidget extends StatelessWidget {
  final Widget child;

  const GradientBackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white, // Top color
            Colors.transparent, // Transparent to allow the horizontal gradient
            Colors.white, // Bottom color
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFBEAD9), // Left color
              Color(0xFFFBEAD9), // Center color
              Color(0xFFFCE0C0), // Right color
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: child,
      ),
    );
  }
}
