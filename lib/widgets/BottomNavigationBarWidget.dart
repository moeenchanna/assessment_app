import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Provider.dart';
import '../utils/Utils.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavigationProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ColorUtils.navBackColor, // Coal black color
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.saved_search_sharp, 0, provider),
          _buildNavItem(Icons.chat, 1, provider),
          _buildNavItem(Icons.home_filled, 2, provider),
          _buildNavItem(Icons.favorite, 3, provider),
          _buildNavItem(Icons.person, 4, provider),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, BottomNavigationProvider provider) {
    final isSelected = provider.selectedIndex == index;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => provider.updateIndex(index),
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.5),
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? ColorUtils.themeColor : ColorUtils.transparent,
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 38, // Fixed size for the circle
            height: 38, // Fixed size for the circle
            decoration: BoxDecoration(
              color: isSelected ? ColorUtils.themeColor : ColorUtils.blackColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: ColorUtils.whiteColor ,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}