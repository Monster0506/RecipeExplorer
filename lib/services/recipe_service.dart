import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class RecipeService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  
  // Fetch initial recipe list (random recipes)
  Future<List<Recipe>> fetchRecipes() async {
    try {
      // Try different endpoints to get recipes
      final urls = [
        '$_baseUrl/search.php?s=',
        '$_baseUrl/search.php?s=chicken',
        '$_baseUrl/search.php?s=beef',
      ];
      
      for (final url in urls) {
        try {
          print('🔍 Trying URL: $url');
          
          final response = await http
              .get(Uri.parse(url))
              .timeout(const Duration(seconds: 10));

          print('📡 Response status: ${response.statusCode}');
          print('📄 Response body length: ${response.body.length}');

          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            print('📊 Parsed data keys: ${data.keys.toList()}');
            
            final meals = data['meals'] as List<dynamic>?;
            print('🍽️ Meals found: ${meals?.length ?? 0}');
            
            if (meals != null && meals.isNotEmpty) {
              print('✅ Success with URL: $url');
              print('✅ First meal: ${meals.first}');
              return meals.map((meal) => Recipe.fromJson(meal)).toList();
            }
          }
        } catch (e) {
          print('❌ Failed with URL $url: $e');
          continue;
        }
      }
      
      print('❌ All URLs failed');
      throw Exception('No recipes found');
    } catch (e) {
      print('💥 Exception caught: $e');
      if (e.toString().contains('timeout')) {
        throw Exception('Request timed out. Please check your internet connection.');
      }
      throw Exception('Failed to load recipes. Please check your internet connection.');
    }
  }

  // Get detailed recipe information
  Future<Recipe> fetchRecipeDetails(String id) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/lookup.php?i=$id'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List<dynamic>?;
        
        if (meals != null && meals.isNotEmpty) {
          return Recipe.fromJson(meals.first);
        } else {
          throw Exception('Recipe not found');
        }
      } else {
        throw Exception('Failed to load recipe details: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('timeout')) {
        throw Exception('Request timed out. Please check your internet connection.');
      }
      throw Exception('Failed to load recipe details. Please check your internet connection.');
    }
  }
} 