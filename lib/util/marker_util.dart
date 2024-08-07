import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'utils.dart';

class MarkerUtil {
  Future<BitmapDescriptor> createCustomMarkerBitmap(
      String text,
      double scale,
      bool showText,
      Color textColor,
      ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = ColorUtil.orangeColor;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    const baseWidth = 200.0;
    const baseHeight = 90.0;
    const basePadding = 5.0;

    final width = baseWidth * scale;
    const height = baseHeight; // Keep height constant
    final padding = basePadding * scale;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, width, height),
        topLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
        bottomRight: const Radius.circular(15),
        bottomLeft: Radius.zero,
      ),
      paint,
    );

    if (scale > 0.1 && showText) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 25 * scale,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout(minWidth: 0, maxWidth: width - padding * 2);
      textPainter.paint(
        canvas,
        Offset(padding, (height - textPainter.height) / 2),
      );
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(pngBytes);
  }

  Future<BitmapDescriptor> createCustomIconBitmap() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = ColorUtil.orangeColor;

    const width = 90.0;
    const height = 90.0;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, width, height),
        topLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
        bottomRight: const Radius.circular(15),
        bottomLeft: Radius.zero,
      ),
      paint,
    );

    const icon = Icons.location_city_sharp;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: 50.0,
        fontFamily: icon.fontFamily,
        color: ColorUtil.whiteColor,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((width - textPainter.width) / 2, (height - textPainter.height) / 2),
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(pngBytes);
  }
}