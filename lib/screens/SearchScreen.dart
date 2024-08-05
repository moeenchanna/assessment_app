import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/Utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showText = true;
  bool _textColorTransparent = false;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.8599423, 67.0004351), // Karachi coordinates
    zoom: 13,
  );

  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation =
        Tween<double>(begin: 1.0, end: 0.4).animate(_animationController)
          ..addListener(() {
            setState(() {
              _updateMarkers();
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.forward) {
              Future.delayed(const Duration(seconds: 1), () {
                if (_animationController.status == AnimationStatus.forward) {
                  setState(() {
                    _textColorTransparent = true;
                  });
                }
              });
            } else if (status == AnimationStatus.completed) {
              setState(() {
                _showText = false;
              });
              _addRandomMarkers();
            }
          });

    _loadMapStyle();
    _addRandomMarkers();
    Future.delayed(const Duration(seconds: 2), () {
      _textColorTransparent = true;
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/dark_theme.json');
    setState(() {});
  }

  Future<void> _addRandomMarkers() async {
    final random = Random();
    final List<LatLng> basePositions = [
      const LatLng(24.905555, 66.970575),
      const LatLng(24.914486, 67.031683),
      const LatLng(24.849679, 67.017652),
      const LatLng(24.861123, 67.031266),
      const LatLng(24.878832, 67.004339),
      const LatLng(24.844410, 66.978313),
    ];

    for (int i = 0; i < basePositions.length; i++) {
      double lat = basePositions[i].latitude;
      double lng = basePositions[i].longitude;

      final markerBitmap = await _createCustomMarkerBitmap(
          '${random.nextInt(15)}.${random.nextInt(99)} mn ₽', _animation.value);
      final iconBitmap = await _createCustomIconBitmap();

      _markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: LatLng(lat, lng),
          icon: _showText ? markerBitmap : iconBitmap,
          anchor: const Offset(0.5, 0.5),
          rotation: 0.0,
          visible: true,
        ),
      );
    }
    setState(() {});
  }

  void _updateMarkers() {
    _addRandomMarkers();
  }

  Future<BitmapDescriptor> _createCustomMarkerBitmap(
      String text, double widthFactor) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = ColorUtils.themeColor;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final width = 200 * widthFactor;
    const height = 100;
    const padding = 10.0;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, width, height.toDouble()),
        topLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
        bottomRight: const Radius.circular(15),
        bottomLeft: Radius.zero,
      ),
      paint,
    );

    if (widthFactor > 0.1 && _showText) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 30,
          color: _textColorTransparent
              ? ColorUtils.transparent
              : ColorUtils.whiteColor,
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout(minWidth: 0, maxWidth: width - padding * 2);
      textPainter.paint(
          canvas, Offset(padding, (height - textPainter.height) / 2));
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(pngBytes);
  }

  Future<BitmapDescriptor> _createCustomIconBitmap() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = ColorUtils.themeColor;

    const width = 90;
    const height = 100;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
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
        color: ColorUtils.whiteColor,
      ),
    );
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset((width - textPainter.width) / 2,
            (height - textPainter.height) / 2));

    final picture = recorder.endRecording();
    final img = await picture.toImage(width, height);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(pngBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              if (_mapStyle != null) {
                _controller.setMapStyle(_mapStyle);
              }
            },
            initialCameraPosition: _initialPosition,
            markers: _markers,
            myLocationEnabled: false,
            trafficEnabled: false,
            mapType: MapType.normal,
            liteModeEnabled: true,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorUtils.whiteColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        Expanded(
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: 'Saint Petersburg',
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: ColorUtils.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.black),
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 130.0, left: 35),
              // Add space from bottom
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlassmorphismButton(
                    icon: Icons.wallet,
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                  ),
                  const SizedBox(height: 10),
                  GlassmorphismButton(
                    icon: Icons.send,
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 130.0, right: 35),
              // Add space from bottom
              child: GlassmorphismButton(
                text: 'List of variants',
                icon: Icons.list,
                onPressed: () {
                  // Add your onPressed code here!
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlassmorphismButton extends StatelessWidget {
  final IconData icon;
  final String? text;
  final VoidCallback onPressed;

  GlassmorphismButton({
    required this.icon,
    required this.onPressed,
    this.text,
  });

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
              color: ColorUtils.whiteColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: ColorUtils.whiteColor.withOpacity(0.1),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: ColorUtils.whiteColor),
                if (text != null) ...[
                  const SizedBox(width: 10),
                  Text(
                    text!,
                    style: const TextStyle(color: ColorUtils.whiteColor),
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
