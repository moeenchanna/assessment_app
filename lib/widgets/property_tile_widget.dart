import 'dart:ui';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/models.dart';
import '../util/utils.dart';

class PropertyTile extends StatelessWidget {
  final PropertyModel property;
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
            FastCachedImage(
              url: property.imageUrl,
              width: double.infinity,
              height: isFull ? 300.0 : 200.0,
              fit: BoxFit.cover,
              errorBuilder: (context, exception, stackTrace) {
                return Container(
                  color: ColorUtil.greyColor,
                  child: const Icon(Icons.error, color: ColorUtil.orangeColor),
                );
              },
              loadingBuilder: (context, progress) {
                return Container(
                  color: ColorUtil.orangeColor,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: progress.progressPercentage.value,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 15,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorUtil.liteBrownColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: isFull
                                  ? const EdgeInsets.only(left: 25)
                                  : const EdgeInsets.only(left: 5),
                              child: Text(
                                property.address,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isFull ? 15.0 : 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: ColorUtil.blackColor,
                                ),
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
                                  color: ColorUtil.blackColor.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: ColorUtil.blackColor,
                              size: isFull ? 10.0 : 8.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
