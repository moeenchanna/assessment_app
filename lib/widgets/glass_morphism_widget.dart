import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphismWidget extends StatelessWidget {
  final IconData icon;
  final String? text;
  final VoidCallback onPressed;

  const GlassMorphismWidget({super.key, required this.icon, this.text, required this.onPressed});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white),
                if (text != null) ...[
                  const SizedBox(width: 10),
                  Text(
                    text!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}