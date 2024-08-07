import 'package:flutter/material.dart';
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
                    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
                          Icon(Icons.location_pin, color: ColorUtils.brownColor, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Saint Petersburg',
                            style: TextStyle(color: ColorUtils.brownColor, fontSize: 14),
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
                      color:
                      ColorUtils.orangeColor, // Background color of the avatar
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
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Adjusted vertical padding
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
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Adjusted vertical padding
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
              padding: const EdgeInsets.all(16.0),
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
                                  fontSize: 32, // Increase the size
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
                  const SizedBox(width: 16),
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
                                style: TextStyle(color: ColorUtils.greyColor),
                              ),
                              const Spacer(),
                              Text(
                                provider.rentOffers,
                                style: const TextStyle(
                                  color: ColorUtils.greyColor,
                                  fontSize: 32, // Increase the size
                                  fontWeight: FontWeight.bold, // Make it bold
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'offers',
                                style: TextStyle(color: ColorUtils.greyColor),
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
              child: ListView.builder(
                itemCount: provider.properties.length,
                itemBuilder: (context, index) {
                  final property = provider.properties[index];
                  return
                    Container(
                      margin: const EdgeInsets.all(5.0), // Adjust the margin as needed
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
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: ColorUtils.whiteColor.withOpacity(0.8),
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      property.address,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: ColorUtils.blackColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                },
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
      imageUrl: 'https://i.pinimg.com/originals/1b/e6/b9/1be6b9c2434f0d2951316407829b98fc.jpg',
    ),
    Property(
      address: 'Example St., 10',
      imageUrl: 'https://i.pinimg.com/originals/2d/00/ef/2d00ef3f0334071a7207dc4969017c6d.png',
    ),
    Property(
      address: 'Gladkova St., 25',
      imageUrl: 'https://i.pinimg.com/originals/d1/83/1f/d1831fd4cdefc09d35f439eb4e217249.jpg',
    ),

  ];

// Add methods to update the state if needed
}

class Property {
  final String address;
  final String imageUrl;

  Property({required this.address, required this.imageUrl});
}
