import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app_ui/widgets/widgets.dart';
import '../providers/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen>
    with TickerProviderStateMixin {
  late AnimationController _popupAnimationController;
  late Animation<double> _popupAnimation;
  final GlobalKey _sendButtonKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    Provider.of<BottomNavigationProvider>(context, listen: false)
        .addListener(_hideMenu);
    _initializePopupAnimation();
    _initializeMapProvider();
    Provider.of<MenuSelectionProvider>(context, listen: false)
        .addListener(_onMenuSelectionChanged);
  }

  void _initializePopupAnimation() {
    _popupAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _popupAnimation = CurvedAnimation(
      parent: _popupAnimationController,
      curve: Curves.easeOutQuad,
      reverseCurve: Curves.easeInQuad,
    );
  }

  void _initializeMapProvider() {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.initialize(context, this);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        mapProvider.startAnimation();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;

    Provider.of<MenuSelectionProvider>(context, listen: false)
        .removeListener(_onMenuSelectionChanged);
    Provider.of<BottomNavigationProvider>(context, listen: false)
        .removeListener(_hideMenu);
    _hideMenu();
    _popupAnimationController.dispose();
    super.dispose();
  }

  void _showMenu() {
    if (_isDisposed) return;
    final RenderBox? renderBox =
        _sendButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy - 4 * 48.0,
        child: ScaleTransition(
          scale: _popupAnimation,
          alignment: Alignment.bottomCenter,
          child: PopupMenuWidget(
            onItemSelected: (String value) {
              if (_isDisposed) return;
              // Handle the selection here (e.g., hide the menu)
              _hideMenu();
              // You can add any additional logic here
              log('Selected: $value');
            },
          ),
        ),
      ),
    );

    if (!_isDisposed) {
      // Add this check
      Overlay.of(context).insert(_overlayEntry!);
      _popupAnimationController.forward();
    }
  }

  void _onMenuSelectionChanged() {
    if (_isDisposed) return; // Add this check
    // This will be called when a menu item is selected
    _hideMenu();
    // You can add any additional logic here based on the selected item
    if (!_isDisposed) {
      // Add this check
      final selectedItem =
          Provider.of<MenuSelectionProvider>(context, listen: false)
              .selectedItem;
      log('Selected item: $selectedItem');
    }
  }

  void _hideMenu() {
    if (_isDisposed) return; // Add this check
    if (_popupAnimationController.isAnimating ||
        _popupAnimationController.isCompleted) {
      _popupAnimationController.reverse().then((_) {
        if (_overlayEntry != null && !_isDisposed) {
          // Add this check
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
              const MapWidget(),
              const SearchBarWidget(),
              MapBottomLeftButtonsWidget(
                  sendButtonKey: _sendButtonKey, showMenu: _showMenu),
              const MapBottomRightButtonsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
