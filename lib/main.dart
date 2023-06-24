import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/models/photos_model.dart';

import 'package:wallpaper/providers/wallpaper_provider.dart';
import 'package:wallpaper/widgets/bottom_navbar.dart';

void main() {
  runApp(const WallpaperApp());
}

class WallpaperApp extends StatelessWidget {
  const WallpaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WallpaperProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WallpaperModel(
              id: '',
              photographer: '',
              photographerId: '',
              photographerUrl: '',
              src: '',
              url: ''),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wallpaper App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainBottomNavBar(),
      ),
    );
  }
}
