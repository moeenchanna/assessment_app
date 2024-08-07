import 'package:flutter/material.dart';

import '../model/models.dart';
import '../util/utils.dart';


class PropertyTile extends StatelessWidget {
  final Property property;
  final bool isFull;

  const PropertyTile({super.key, required this.property, required this.isFull});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        border: Border.all(color: ColorUtil.whiteColor, width: 5.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Image.network(
              property.imageUrl,
              width: double.infinity,
              height: isFull ? 300.0 : 200.0,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorUtil.liteBrownColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        property.address,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isFull ? 16.0 : 12.0,
                          fontWeight: FontWeight.w400,
                          color: ColorUtil.blackColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorUtil.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: ColorUtil.blackColor,
                        size: isFull ? 14.0 : 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}