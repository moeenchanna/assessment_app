import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app_ui/screen/home_screen.dart';

import 'providers/provider.dart';
import 'real_estate_app.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: const RealEstateApp(),
    ),
  );
}