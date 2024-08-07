import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app_ui/util/utils.dart';
import 'package:real_estate_app_ui/widgets/widgets.dart';
import '../providers/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    final buyOffer = provider.getOfferByType(AppStrings.buyText);
    final rentOffer = provider.getOfferByType(AppStrings.rentText);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtil.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrentLocationWidget(),
                AvatarWidget()
              ],
            ),
            const GreetingWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: OfferWidget(
                              offerType: AppStrings.buyText,
                              offerCount: buyOffer.count,
                              color: ColorUtil.orangeColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OfferWidget(
                              offerType: AppStrings.rentText,
                              offerCount: rentOffer.count,
                              color: ColorUtil.whiteColor,
                              textColor: ColorUtil.brownColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: StaggeredGrid.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        children: List.generate(provider.properties.length, (index) {
                          final property = provider.properties[index];
                          final isFull = index % 4 == 0 || index % 4 == 3;
                          return StaggeredGridTile.count(
                            crossAxisCellCount: isFull ? 4 : 2,
                            mainAxisCellCount: 2,
                            child: PropertyTile(property: property, isFull: isFull),
                          );
                        }),
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