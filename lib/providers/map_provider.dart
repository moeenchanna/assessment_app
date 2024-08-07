import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../repository/repositories.dart';
import '../util/utils.dart';

class MapProvider with ChangeNotifier {
  late GoogleMapController _controller;
  final Map<String, Marker> _markers = {};
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;
  bool _showText = true;
  bool _animationStarted = false;
  String? _mapStyle;

  final MapRepository _mapRepository = MapRepository();
  final MarkerUtil _markerUtils = MarkerUtil();

  Set<Marker> get markers => _markers.values.toSet();
  bool get showText => _showText;
  bool get animationStarted => _animationStarted;

  void initialize(BuildContext context, TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(
      begin: ColorUtil.whiteColor,
      end: ColorUtil.orangeColor,
    ).animate(_animationController);

    _animationController.addListener(() {
      _updateMarkers();
      notifyListeners();
    });

    _animationController.addStatusListener(_handleAnimationStatus);

    _loadMapStyle(context);
    _initializeMarkers();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _showText = false;
      _updateMarkers();
      notifyListeners();
    }
  }

  Future<void> _loadMapStyle(BuildContext context) async {
    _mapStyle = await _mapRepository.loadMapStyle(context);
    notifyListeners();
  }

  Future<void> _initializeMarkers() async {
    final markerData = _mapRepository.getRandomMarkerData();
    for (var data in markerData) {
      final markerBitmap = await _markerUtils.createCustomMarkerBitmap(
        data.text,
        1.0,
        true,
        ColorUtil.whiteColor,
      );

      _markers[data.id] = Marker(
        markerId: MarkerId(data.id),
        position: data.position,
        icon: markerBitmap,
        anchor: const Offset(0.5, 0.5),
      );
    }
    notifyListeners();
  }

  void _updateMarkers() async {
    for (var entry in _markers.entries) {
      final data = _mapRepository.getMarkerDataById(entry.key);
      if (data != null) {
        if (_showText) {
          final markerBitmap = await _markerUtils.createCustomMarkerBitmap(
            data.text,
            _animation.value,
            true,
            _colorAnimation.value ?? ColorUtil.whiteColor,
          );

          _markers[entry.key] = entry.value.copyWith(
            iconParam: markerBitmap,
          );
        } else {
          final iconBitmap = await _markerUtils.createCustomIconBitmap();
          _markers[entry.key] = entry.value.copyWith(
            iconParam: iconBitmap,
          );
        }
      }
    }
    notifyListeners();
  }

  void startAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      _animationStarted = true;
      _animationController.forward();
      notifyListeners();
    });
  }

  void resetScreen() {
    _showText = true;
    _animationStarted = false;
    _animationController.reset();
    _initializeMarkers();
  }

  void setMapController(GoogleMapController controller) {
    _controller = controller;
    if (_mapStyle != null) {
      _controller.setMapStyle(_mapStyle);
    }
  }
}