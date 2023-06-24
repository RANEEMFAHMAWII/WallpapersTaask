import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/widgets/wallpaper_item.dart';

import '../providers/wallpaper_provider.dart';
import '../widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpaperProvider =
        Provider.of<WallpaperProvider>(context, listen: false);
    final wallpapers = wallpaperProvider.wallpapers;

    return Scaffold(
      appBar: const MainAppBar(
        title: 'WallPapers',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: wallpaperProvider.fetchWallpapers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error occurred'),
              );
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: wallpapers.length,
                itemBuilder: (context, index) {
                  final wallpaper = wallpapers[index];
                  return WallpaperItem(wallpaper: wallpaper);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
