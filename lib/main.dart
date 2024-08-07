import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/provider.dart';
import 'real_estate_app.dart';


Future<void> main() async {
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (context) => MapProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => MenuSelectionProvider()),

      ],
      child: const RealEstateApp(),
    ),
  );
}