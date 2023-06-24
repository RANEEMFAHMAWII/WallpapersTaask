import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper/models/photos_model.dart';

class ApiService {
  static const String apiKey =
      'fRzyNpnQ9Tn9FYflfegBPCtTaBXEflmncdmbDn62gePniIaiK5Iw288q';

  static Future<List<WallpaperModel>> fetchWallpapers() async {
    try {
      const url = 'https://api.pexels.com/v1/curated?per_page=10';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<WallpaperModel> wallpapers = [];

        for (final wallpaperData in data['photos']) {
          final id = wallpaperData['id'].toString();
          final photographer = wallpaperData['photographer'].toString();
          final src = wallpaperData['src']['portrait'].toString();
          final photographerId = wallpaperData['photographerId'].toString();
          final photographerUrl = wallpaperData['photographerUrl'].toString();
          final wallpaper = WallpaperModel(
            id: id,
            url: wallpaperData['url'],
            photographer: photographer,
            photographerId: photographerId,
            photographerUrl: photographerUrl,
            src: src,
            isFavorite: false,
          );
          wallpapers.add(wallpaper);
        }

        return wallpapers;
      } else {
        throw Exception('Failed to fetch wallpapers');
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<WallpaperModel>> fetchSearchResults(String query) async {
    try {
      final url = 'https://api.pexels.com/v1/search?query=$query&per_page=20';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final List<WallpaperModel> searchResults = [];
        for (final wallpaperData in data['photos']) {
          final id = wallpaperData['id'].toString();
          final photographer = wallpaperData['photographer'].toString();
          final src = wallpaperData['src']['portrait'].toString();
          final photographerId = wallpaperData['photographerId'].toString();
          final photographerUrl = wallpaperData['photographerUrl'].toString();
          final wallpaper = WallpaperModel(
            id: id,
            url: wallpaperData['url'],
            photographer: photographer,
            photographerId: photographerId,
            photographerUrl: photographerUrl,
            src: src,
            isFavorite: false,
          );
          searchResults.add(wallpaper);
        }

        return searchResults;
      } else {
        throw Exception('Failed to fetch search results');
      }
    } catch (error) {
      throw Exception('Failed to fetch search results: $error');
    }
  }
}
