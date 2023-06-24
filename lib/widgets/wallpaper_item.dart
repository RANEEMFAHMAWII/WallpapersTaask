import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/pages/details_screen.dart';
import 'package:wallpaper/providers/wallpaper_provider.dart';

import '../models/photos_model.dart';

class WallpaperItem extends StatelessWidget {
  final WallpaperModel wallpaper;

  const WallpaperItem({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    final wallpaperProvider =
        Provider.of<WallpaperProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Stack(
        children: [
          GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.transparent,
              leading: Consumer(
                builder: (context, value, child) => Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        wallpaperProvider.toggleFavorite(wallpaper.id);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: wallpaper.isFavorite
                              ? const Text('removed from Favorites!')
                              : const Text('Added from Favorites!'),
                          duration: const Duration(seconds: 3),
                          action:
                              SnackBarAction(label: 'Undo', onPressed: () {}),
                        ));
                      },
                      icon: Icon(wallpaper.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.download)),
                  ],
                ),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WallpaperDetailsScreen(
                          wallpaperId: wallpaper.id,
                          wallpaperTilte: wallpaper.photographer,
                        )));
              },
              child: Image.network(
                wallpaper.src,
                fit: BoxFit.fill,
                height: 150,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridTileBar(
              title: Text(
                wallpaper.photographer,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
