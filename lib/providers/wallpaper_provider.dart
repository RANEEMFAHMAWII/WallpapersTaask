import 'package:flutter/material.dart';
import 'package:wallpaper/models/photos_model.dart';

import '../services/api_services.dart';
import '../utils/database_helper.dart';

class WallpaperProvider with ChangeNotifier {
  List<WallpaperModel> _wallpapers = [];
  List<WallpaperModel> get wallpapers => _wallpapers;
  final List<WallpaperModel> _favorites = [];
  List<WallpaperModel> get favorites => _favorites;
  List<WallpaperModel> _searchResults = [];
  List<WallpaperModel> get searchResults => _searchResults;

  Future<List<WallpaperModel>> fetchWallpapers() async {
    try {
      final List<WallpaperModel> wallpapers =
          await ApiService.fetchWallpapers();
      final List<String> favoriteWallpapers =
          await DatabaseHelper.getFavorites();
      for (final wallpaper in wallpapers) {
        wallpaper.isFavorite = favoriteWallpapers.contains(wallpaper.id);
      }

      _wallpapers = wallpapers;
      notifyListeners();
      return wallpapers;
    } catch (error) {
      rethrow;
    }
  }

  WallpaperModel findById(String id) {
    return _wallpapers.firstWhere((wallpaper) => wallpaper.id == id);
  }

  void searchWallpapers(String query) {
    _searchResults = _wallpapers
        .where((wallpaper) =>
            wallpaper.photographer.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> toggleFavorite(String wallpaperId) async {
    final wallpaperIndex =
        _wallpapers.indexWhere((wallpaper) => wallpaper.id == wallpaperId);
    if (wallpaperIndex != -1) {
      final wallpaper = _wallpapers[wallpaperIndex];
      wallpaper.isFavorite = !wallpaper.isFavorite;
      if (wallpaper.isFavorite) {
        await DatabaseHelper.insertFavorite(wallpaperId);
      } else {
        await DatabaseHelper.deleteFavorite(wallpaperId);
      }
      notifyListeners();
    }
  }

  Future<List<WallpaperModel>> getFavoriteWallpapers() async {
    final List<String> favoriteIds = await DatabaseHelper.fetchFavorites();
    final List<WallpaperModel> favoriteWallpapers = _wallpapers
        .where((wallpaper) => favoriteIds.contains(wallpaper.id))
        .toList();
    return favoriteWallpapers;
  }
}
