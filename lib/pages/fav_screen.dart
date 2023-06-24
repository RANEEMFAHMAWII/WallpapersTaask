import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/widgets/wallpaper_item.dart';

import '../models/photos_model.dart';
import '../providers/wallpaper_provider.dart';
import '../widgets/app_bar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MainAppBar(
          title: 'Favorites',
        ),
        body: FutureBuilder(
          future:
              Provider.of<WallpaperProvider>(context).getFavoriteWallpapers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No Favorites wallpapers'),
              );
            } else {
              final List<WallpaperModel> favoriteWallpapers = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: favoriteWallpapers.length,
                itemBuilder: (context, index) {
                  final favoriteWallpaper = favoriteWallpapers[index];
                  return WallpaperItem(
                    wallpaper: favoriteWallpaper,
                  );
                },
              );
            }
          },
        ));
  }
}
