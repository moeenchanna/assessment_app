import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
import '../util/utils.dart';
import '../widgets/widgets.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showText = true;
  bool _textColorTransparent = false;

  // AnimatedPopupMenu variables
  late AnimationController _popupAnimationController;
  late Animation<double> _popupAnimation;
  final GlobalKey _sendButtonKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.8599423, 67.0004351), // Karachi coordinates
    zoom: 11,
  );

  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    Provider.of<BottomNavigationProvider>(context, listen: false).addListener(_hideMenu);

    // Initialize the main animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Initialize the main animation
    _animation =
    Tween<double>(begin: 1.0, end: 0.4).animate(_animationController)
      ..addListener(() {
        if (mounted) {
          setState(() {
            _updateMarkers();
          });
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          Future.delayed(const Duration(seconds: 1), () {
            if (_animationController.status == AnimationStatus.forward && mounted) {
              setState(() {
                _textColorTransparent = true;
              });
            }
          });
        } else if (status == AnimationStatus.completed && mounted) {
          setState(() {
            _showText = false;
          });
          _addRandomMarkers();
        }
      });

    // Initialize the popup animation controller
    _popupAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Initialize the popup animation
    _popupAnimation = CurvedAnimation(
      parent: _popupAnimationController,
      curve: Curves.easeOutQuad,
      reverseCurve: Curves.easeInQuad,
    );

    _loadMapStyle();
    _addRandomMarkers();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _textColorTransparent = true;
          _animationController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    Provider.of<BottomNavigationProvider>(context, listen: false).removeListener(_hideMenu);

    _hideMenu(); // Ensure the popup menu is hidden
    _animationController.dispose();
    _popupAnimationController.dispose();
    _controller.dispose();
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
      const LatLng(24.861032, 66.887905),
      const LatLng(24.944417, 66.904901),
      const LatLng(24.992041, 67.072544),
      const LatLng(24.904143, 67.087658),
      const LatLng(24.904143, 67.087658),
      const LatLng(24.843459, 67.072534),
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
    if (mounted) {
      setState(() {});
    }
  }

  void _updateMarkers() {
    _addRandomMarkers();
  }

  Future<BitmapDescriptor> _createCustomMarkerBitmap(
      String text, double widthFactor) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = ColorUtil.orangeColor;
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
              ? ColorUtil.transparent
              : ColorUtil.whiteColor,
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
    final paint = Paint()..color = ColorUtil.orangeColor;

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
        color: ColorUtil.whiteColor,
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

  Widget _buildMenuItem(String text, String value) {
    IconData icon;
    Color iconColor;
    switch (value) {
      case 'cosy':
        icon = Icons.check_circle_outline;
        iconColor = ColorUtil.greyColor;
        break;
      case 'price':
        icon = Icons.account_balance_wallet_outlined;
        iconColor = ColorUtil.orangeColor;
        break;
      case 'infrastructure':
        icon = Icons.delete_outline;
        iconColor = ColorUtil.greyColor;
        break;
      case 'none':
        icon = Icons.layers;
        iconColor = ColorUtil.greyColor;
        break;
      default:
        icon = Icons.error_outline;
        iconColor = ColorUtil.greyColor;
    }

    return InkWell(
      onTap: () {
        _hideMenu();
        print('Selected: $value');
        // Handle the selection here
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                color: value == 'price'
                    ? ColorUtil.orangeColor
                    : ColorUtil.greyColor,
                fontSize: 16,
                fontWeight : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMenu() {
    final RenderBox? renderBox =
    _sendButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy - 4 * 48.0,
        // Adjust based on your menu item height and count
        child: ScaleTransition(
          scale: _popupAnimation,
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 150, // Minimum width
                    maxWidth: 300, // Maximum width
                  ),
                  child: IntrinsicWidth(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBF5EB), // New background color
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildMenuItem('Cosy areas', 'cosy'),
                          _buildMenuItem('Price', 'price'),
                          _buildMenuItem('Infrastructure', 'infrastructure'),
                          _buildMenuItem('Without any layer', 'none'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _popupAnimationController.forward();
  }

  void _hideMenu() {
    if (_popupAnimationController.isAnimating || _popupAnimationController.isCompleted) {
      _popupAnimationController.reverse().then((_) {
        if (_overlayEntry != null) {
          _overlayEntry!.remove();
          _overlayEntry = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _hideMenu();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
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
                          color: ColorUtil.whiteColor,
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
                                  hintText: "Saint Petersburg",
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
                        color: ColorUtil.whiteColor,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
        
                      GlassMorphismWidget(
                        icon: Icons.wallet,
                        onPressed: () {
        // Add your onPressed code here!
                        },
                      ),
                      const SizedBox(height: 10),
                      GlassMorphismWidget(
                        key: _sendButtonKey,
                        icon: Icons.send,
                        onPressed: _showMenu,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 130.0, right: 35),
                  child: GlassMorphismWidget(
                    text: "List of variants",
                    icon: Icons.list,
                    onPressed: () {
        // Add your onPressed code here!
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}