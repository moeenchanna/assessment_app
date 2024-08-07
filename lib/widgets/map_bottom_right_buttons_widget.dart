import 'package:flutter/material.dart';

import '../util/utils.dart';
import 'widgets.dart';

class MapBottomRightButtonsWidget extends StatelessWidget {
  const MapBottomRightButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 130.0, right: 20),
        child: GlassMorphismWidget(
          text: AppStrings.variantText,
          icon: Icons.list,
          onPressed: () {
            // Add your variant button functionality here
          },
        ),
      ),
    );
  }
}