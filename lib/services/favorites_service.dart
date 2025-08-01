import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_recipes';

  // Retrieve stored favorite IDs
  Future<Set<String>> getFavoriteIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString(_favoritesKey);
      
      if (favoritesJson != null) {
        final List<dynamic> favoritesList = json.decode(favoritesJson);
        return Set<String>.from(favoritesList);
      }
      return <String>{};
    } catch (e) {
      // If there's an error reading favorites, return empty set
      return <String>{};
    }
  }

  // Add recipe to favorites
  Future<void> addFavorite(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavoriteIds();
      favorites.add(id);
      
      await prefs.setString(_favoritesKey, json.encode(favorites.toList()));
    } catch (e) {
      throw Exception('Failed to add recipe to favorites');
    }
  }

  // Remove recipe from favorites
  Future<void> removeFavorite(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavoriteIds();
      favorites.remove(id);
      
      await prefs.setString(_favoritesKey, json.encode(favorites.toList()));
    } catch (e) {
      throw Exception('Failed to remove recipe from favorites');
    }
  }

  // Check if recipe is favorited
  Future<bool> isFavorite(String id) async {
    try {
      final favorites = await getFavoriteIds();
      return favorites.contains(id);
    } catch (e) {
      return false;
    }
  }
} 