import 'package:flutter/material.dart';
import 'package:animated_digit/animated_digit.dart';

import '../util/utils.dart';

class OfferWidget extends StatelessWidget {
  final String offerType;
  final int offerCount;
  final Color color;
  final Color textColor;

  const OfferWidget({
    Key? key,
    required this.offerType,
    required this.offerCount,
    required this.color,
    this.textColor = ColorUtil.whiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 150,
        height: 150,
        decoration: ShapeDecoration(
          color: color,
          shape: offerType == 'BUY' ? const CircleBorder() : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  offerType,
                  style: TextStyle(color: textColor),
                ),
                const Spacer(),
                AnimatedDigitWidget(
                  value: offerCount,
                  textStyle: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  fractionDigits: 0,
                  enableSeparator: true,
                  separateSymbol: " ",
                  duration: const Duration(seconds: 1),
                ),
                const SizedBox(height: 8),
                Text(
                  'offers',
                  style: TextStyle(color: textColor),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}