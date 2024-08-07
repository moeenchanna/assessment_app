import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app_ui/util/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    margin:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      color: ColorUtils.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtils.blackColor.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_pin,
                              color: ColorUtils.brownColor, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Saint Petersburg',
                            style: TextStyle(
                                color: ColorUtils.brownColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    // Inner padding for the image
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtils
                          .orangeColor, // Background color of the avatar
                    ),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/people19.png'),
                      backgroundColor: ColorUtils
                          .transparent, // Make the background of the image transparent
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0), // Adjusted vertical padding
                    child: const Text(
                      'Hi, Marina',
                      style: TextStyle(
                        fontSize: 22, // Adjusted font size
                        fontWeight: FontWeight.w500, // Adjusted font weight
                        color: ColorUtils.brownColor, // Color for the text
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0), // Adjusted vertical padding
                    child: const Text(
                      'let\'s select your perfect place',
                      style: TextStyle(
                        fontSize: 32, // Adjusted font size
                        color: ColorUtils.blackColor, // Color for the text
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: const ShapeDecoration(
                        color: ColorUtils.orangeColor,
                        shape: CircleBorder(),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'BUY',
                                style: TextStyle(color: ColorUtils.whiteColor),
                              ),
                              const Spacer(),
                              Text(
                                provider.buyOffers,
                                style: const TextStyle(
                                  color: ColorUtils.whiteColor,
                                  fontSize: 32,
                                  // Increase the size
                                  fontWeight: FontWeight.bold, // Make it bold
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'offers',
                                style: TextStyle(color: ColorUtils.whiteColor),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: ShapeDecoration(
                        color: ColorUtils.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'RENT',
                                style: TextStyle(color: ColorUtils.brownColor),
                              ),
                              const Spacer(),
                              Text(
                                provider.rentOffers,
                                style: const TextStyle(
                                  color: ColorUtils.brownColor,
                                  fontSize: 32,
                                  // Increase the size
                                  fontWeight: FontWeight.bold, // Make it bold
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'offers',
                                style: TextStyle(color: ColorUtils.brownColor),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: List.generate(provider.properties.length, (index) {
                    final property = provider.properties[index];
                    if (index % 4 == 0 || index % 4 == 3) {
                      // Full-width item (first and fourth in each group of 4)
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 4,
                        mainAxisCellCount: 2,
                        child: PropertyTile(property: property, isFull: true),
                      );
                    } else {
                      // Half-width items (second and third in each group of 4)
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: PropertyTile(property: property, isFull: false),
                      );
                    }
                  }),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class PropertyTile extends StatelessWidget {
  final Property property;
  final bool isFull;

  const PropertyTile({Key? key, required this.property, required this.isFull}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        border: Border.all(color: ColorUtils.whiteColor, width: 5.0),
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
                  color: ColorUtils.liteBrownColor.withOpacity(0.9),
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
                          fontSize: isFull ? 16.0 : 13.0,
                          fontWeight: FontWeight.w400,
                          color: ColorUtils.blackColor,
                        ),
                      ),
                    ),
                    Container(
                      width:  40,
                      height: 40,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorUtils.whiteColor,
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
                        color: ColorUtils.blackColor,
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

class HomeProvider with ChangeNotifier {
  String buyOffers = "1 034";
  String rentOffers = "2 212";
  List<Property> properties = [
    Property(
      address: 'Gladkova St., 25',
      imageUrl:
          'https://images.livspace-cdn.com/plain/https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/sites/2/2022/09/20124936/Cover-3.jpg',
    ),
    Property(
      address: 'Gladkova St., 25',
      imageUrl:
          'https://i.pinimg.com/originals/1b/e6/b9/1be6b9c2434f0d2951316407829b98fc.jpg',
    ),
    Property(
      address: 'Example St., 10',
      imageUrl:
          'https://i.pinimg.com/originals/2d/00/ef/2d00ef3f0334071a7207dc4969017c6d.png',
    ),

    Property(
      address: 'Gladkova St., 25',
      imageUrl:
      'https://images.livspace-cdn.com/plain/https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/sites/2/2022/09/20124936/Cover-3.jpg',
    ),
    // Property(
    //   address: 'Gladkova St., 25',
    //   imageUrl:
    //       'https://i.pinimg.com/originals/d1/83/1f/d1831fd4cdefc09d35f439eb4e217249.jpg',
    // ),
  ];

  Map<String, bool> slideCompleted = {};

  void setSlideCompleted(String address) {
    slideCompleted[address] = true;
    notifyListeners();
  }

  bool isSlideCompleted(String address) {
    return slideCompleted[address] ?? false;
  }

// Add methods to update the state if needed
}

class Property {
  final String address;
  final String imageUrl;

  Property({required this.address, required this.imageUrl});
}
