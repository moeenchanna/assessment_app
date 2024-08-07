import 'package:flutter/material.dart';
import 'package:real_estate_app_ui/widgets/widgets.dart';

class BottomNavigationBarAnimatedWidget extends StatefulWidget {
  const BottomNavigationBarAnimatedWidget({super.key});

  @override
  BottomNavigationBarAnimatedState createState() =>
      BottomNavigationBarAnimatedState();
}

class BottomNavigationBarAnimatedState
    extends State<BottomNavigationBarAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: const Padding(
        padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: BottomNavigationBarWidget(),
      ),
    );
  }
}
