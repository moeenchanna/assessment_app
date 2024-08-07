import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/provider.dart';
import 'real_estate_app.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BottomNavigationProvider(),
      child: const RealEstateApp(),
    ),
  );
}