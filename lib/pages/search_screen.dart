import 'package:flutter/material.dart';
import 'package:wallpaper/models/photos_model.dart';
import 'package:wallpaper/widgets/app_bar.dart';

import '../services/api_services.dart';
import '../widgets/wallpaper_item.dart';

class SearchScreen extends StatefulWidget {
  // final String search;

  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<WallpaperModel> searchResults = [];

  TextEditingController searchController = TextEditingController();

  void performSearch(String query) {
    ApiService.fetchSearchResults(query).then((results) {
      setState(() {
        searchResults = results;
      });
    }).catchError((error) {
      print('Error fetching search results: $error');
      // Handle the error as desired
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'Search for wallpaper'),
      body: Column(children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xfff5f8fd),
            borderRadius: BorderRadius.circular(30),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                onChanged: (value) {
                  performSearch(value);
                },
                controller: searchController,
                decoration: const InputDecoration(
                    hintText: "search wallpapers", border: InputBorder.none),
              )),
              InkWell(onTap: () {}, child: const Icon(Icons.search))
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
            child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final wallpaper = searchResults[index];
            return WallpaperItem(wallpaper: wallpaper);
          },
        ))
      ]),
    );
  }
}
