import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../providers/provider.dart';
import '../util/utils.dart';

class PopupMenuWidget extends StatelessWidget {
  final Function(String) onItemSelected;

  const PopupMenuWidget({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 150,
              maxWidth: 300,
            ),
            child: IntrinsicWidth(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF5EB),
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
                    _buildMenuItem(context, AppStrings.cosyAreas, 'cosy'),
                    _buildMenuItem(context, AppStrings.price, 'price'),
                    _buildMenuItem(context, AppStrings.infrastructure, 'infrastructure'),
                    _buildMenuItem(context, AppStrings.withoutAnyLayer, 'none'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String text, String value) {
    final menuSelectionProvider = Provider.of<MenuSelectionProvider>(context, listen: false);

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
        menuSelectionProvider.setSelectedItem(value);
        onItemSelected(value);  // Call the callback
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
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}