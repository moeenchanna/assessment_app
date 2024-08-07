import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/provider.dart';
import 'screen/screens.dart';
import 'util/color_utils.dart';
import 'widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
      builder: (context, provider, child) {
        // Update the System UI overlay style based on the selected index
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: provider.selectedIndex == 2
              ? ColorUtils.transparent
              : ColorUtils.blackColor,
          statusBarIconBrightness: provider.selectedIndex == 2
              ? Brightness.dark
              : Brightness.light,
        ));
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          home: GradientBackgroundWidget(
            child: Scaffold(
              backgroundColor: provider.selectedIndex == 2
                  ? ColorUtils.transparent
                  : ColorUtils.blackColor,
              body: Stack(
                children: [
                  SafeArea(
                    child: _buildBody(provider.selectedIndex),
                  ),
                  const Positioned(
                    bottom: 20,
                    left: 15,
                    right: 15,
                    child: BottomNavigationBarAnimatedWidget(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(int selectedIndex) {

    switch (selectedIndex) {
      case 0:
        return const SearchScreen();
      case 1:
      case 3:
      case 4:
        return Container(); // Return an empty container or a placeholder widget
      case 2:
        return const HomeScreen();
      default:
        return const Center(child: Text('Unknown Screen'));
    }
  }


}