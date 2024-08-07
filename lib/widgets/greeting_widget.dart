import 'package:flutter/material.dart';
import '../util/utils.dart';

class GreetingWidget extends StatelessWidget {
  final String? name;
  final TextStyle? greetingStyle;
  final TextStyle? selectStyle;
  final TextStyle? placeStyle;
  final EdgeInsetsGeometry? padding;

  const GreetingWidget({
    super.key,
    this.name,
    this.greetingStyle,
    this.selectStyle,
    this.placeStyle,
    this.padding,
  });

  Widget _buildTextWidget(String text, TextStyle? style, TextStyle defaultStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Text(
        text,
        style: style ?? defaultStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextWidget(
            AppStrings.greeting + (name ?? AppStrings.name),
            greetingStyle,
            const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: ColorUtil.brownColor,
            ),
          ),
          const SizedBox(height: 4),
          _buildTextWidget(
            AppStrings.selectText,
            selectStyle,
            const TextStyle(
              fontSize: 32,
              color: ColorUtil.blackColor,
            ),
          ),
          _buildTextWidget(
            AppStrings.placeText,
            placeStyle,
            const TextStyle(
              fontSize: 32,
              color: ColorUtil.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}