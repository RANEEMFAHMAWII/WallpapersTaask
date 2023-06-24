import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/providers/wallpaper_provider.dart';
import 'package:wallpaper/widgets/app_bar.dart';

class WallpaperDetailsScreen extends StatelessWidget {
  final String wallpaperId;
  final String wallpaperTilte;

  const WallpaperDetailsScreen({
    super.key,
    required this.wallpaperId,
    required this.wallpaperTilte,
  });

  @override
  Widget build(BuildContext context) {
    final WallpaperProvider wallpaperProvider =
        Provider.of<WallpaperProvider>(context);
    final WallpaperModel wallpaper = wallpaperProvider.findById(wallpaperId);

    return Scaffold(
        appBar: MainAppBar(title: wallpaperTilte),
        body: Stack(
          children: [
            Image.network(wallpaper.src),
            GridTileBar(
              backgroundColor: Colors.transparent,
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download),
              ),
            ),
            Consumer(
              builder: (context, value, child) => Row(
                children: [
                  IconButton(
                    onPressed: () {
                      wallpaperProvider.toggleFavorite(wallpaper.id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: wallpaper.isFavorite
                            ? const Text('Added from Favorites!')
                            : const Text('removed from Favorites!'),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(label: 'Undo', onPressed: () {}),
                      ));
                    },
                    icon: Icon(wallpaper.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
