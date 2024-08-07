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
    return Container(
      width: 200,
      height: 190,
      decoration: ShapeDecoration(
        color: color,
        shape: offerType == AppStrings.buyText
            ? const CircleBorder()
            : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              offerType,
              style: TextStyle(color: textColor),
            ),
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
              duration: const Duration(seconds: 2),
            ),
            Text(
              AppStrings.offerText,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}