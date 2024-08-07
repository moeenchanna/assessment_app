import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app_ui/util/utils.dart';
import 'package:real_estate_app_ui/widgets/widgets.dart';
import '../providers/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OfferWidget(
                              offerType: 'BUY',
                              offerCount: provider.buyOffers,
                              color: ColorUtil.orangeColor,
                            ),
                          ),
                          const SizedBox(width: 20), // Adjust this value to increase/decrease space between widgets
                          Expanded(
                            child: OfferWidget(
                              offerType: 'RENT',
                              offerCount: provider.rentOffers,
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
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children:
                            List.generate(provider.properties.length, (index) {
                          final property = provider.properties[index];
                          final isFull = index % 4 == 0 || index % 4 == 3;
                          return StaggeredGridTile.count(
                            crossAxisCellCount: isFull ? 4 : 2,
                            mainAxisCellCount: 2,
                            child: PropertyTile(
                                property: property, isFull: isFull),
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
