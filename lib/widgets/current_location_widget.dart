import 'package:flutter/material.dart';
import '../util/utils.dart';

class CurrentLocationWidget extends StatelessWidget {
  final String? locationText;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CurrentLocationWidget({
    super.key,
    this.locationText = AppStrings.defaultLocation,
    this.icon = Icons.location_pin,
    this.backgroundColor = ColorUtil.whiteColor,
    this.iconColor = ColorUtil.brownColor,
    this.textColor = ColorUtil.brownColor,
    this.iconSize = 18,
    this.fontSize = 14,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: margin ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ColorUtil.blackColor.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(icon, color: iconColor, size: iconSize),
              if (icon != null && locationText != null)
                const SizedBox(width: 6),
              if (locationText != null)
                Text(
                  locationText!,
                  style: TextStyle(color: textColor, fontSize: fontSize),
                ),
            ],
          ),
        ),
      ),
    );
  }
}