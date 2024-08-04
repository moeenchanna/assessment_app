import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'RealEstateApp.dart';
import 'provider/Provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BottomNavigationProvider(),
      child: const RealEstateApp(),
    ),
  );
}