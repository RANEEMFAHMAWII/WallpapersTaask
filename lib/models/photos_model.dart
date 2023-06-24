import 'package:flutter/material.dart';

class WallpaperModel with ChangeNotifier {
  final String id;
  final String url;
  final String photographer;
  final String photographerUrl;
  final String photographerId;
  final String src;
  bool isFavorite;

  WallpaperModel({
    required this.id,
    required this.url,
    required this.photographer,
    required this.photographerId,
    required this.photographerUrl,
    required this.src,
    this.isFavorite = false,
  });
}
