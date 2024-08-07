import 'package:flutter/material.dart';

import 'widgets.dart';

class MapBottomLeftButtonsWidget extends StatelessWidget {
  final GlobalKey sendButtonKey;
  final VoidCallback showMenu;

  const MapBottomLeftButtonsWidget({
    super.key,
    required this.sendButtonKey,
    required this.showMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 130.0, left: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlassMorphismWidget(
              icon: Icons.wallet,
              onPressed: () {
                // Add your wallet button functionality here
              },
            ),
            const SizedBox(height: 10),
            GlassMorphismWidget(
              key: sendButtonKey,
              icon: Icons.send,
              onPressed: showMenu,
            ),
          ],
        ),
      ),
    );
  }
}