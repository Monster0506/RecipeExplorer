import 'package:flutter/foundation.dart';
import '../services/favorites_service.dart';

class FavoritesProvider with ChangeNotifier {
  final FavoritesService _favoritesService = FavoritesService();
  Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => _favoriteIds;

  // Initialize favorites from storage
  Future<void> loadFavorites() async {
    try {
      _favoriteIds = await _favoritesService.getFavoriteIds();
      notifyListeners();
    } catch (e) {
      // Handle error silently, favorites will be empty
      _favoriteIds = {};
    }
  }

  // Check if a recipe is favorited
  bool isFavorite(String id) {
    return _favoriteIds.contains(id);
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String id) async {
    try {
      if (_favoriteIds.contains(id)) {
        await _favoritesService.removeFavorite(id);
        _favoriteIds.remove(id);
      } else {
        await _favoritesService.addFavorite(id);
        _favoriteIds.add(id);
      }
      notifyListeners();
    } catch (e) {
      // Handle error - could show a snackbar or toast
      debugPrint('Error toggling favorite: $e');
    }
  }
} 