import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/favorites_provider.dart';
import '../services/recipe_service.dart';
import '../widgets/recipe_card.dart';
import '../widgets/recipe_skeleton.dart';
import '../widgets/error_widget.dart';
import '../widgets/theme_toggle_button.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final RecipeService _recipeService = RecipeService();
  List<Recipe> _favoriteRecipes = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFavoriteRecipes();
  }

  Future<void> _loadFavoriteRecipes() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final favoritesProvider = context.read<FavoritesProvider>();
      final favoriteIds = favoritesProvider.favoriteIds;

      if (favoriteIds.isEmpty) {
        setState(() {
          _favoriteRecipes = [];
          _isLoading = false;
        });
        return;
      }

      // Fetch details for all favorite recipes
      List<Recipe> recipes = [];
      for (String id in favoriteIds) {
        try {
          final recipe = await _recipeService.fetchRecipeDetails(id);
          recipes.add(recipe);
        } catch (e) {
          // Skip recipes that can't be loaded
          print('Failed to load favorite recipe $id: $e');
        }
      }

      setState(() {
        _favoriteRecipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load favorite recipes: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        actions: [
          const ThemeToggleButton(),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const RecipeListSkeleton(itemCount: 8);
    }

    if (_errorMessage != null) {
      return ErrorDisplayWidget(
        message: _errorMessage!,
        onRetry: _loadFavoriteRecipes,
      );
    }

    if (_favoriteRecipes.isEmpty) {
      return _buildEmptyState();
    }

    return _buildRecipeGrid();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No favorite recipes yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start exploring recipes and add them to your favorites!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.explore),
            label: const Text('Explore Recipes'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth < 600 ? 1 :
                           constraints.maxWidth < 1200 ? 2 : 3;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _favoriteRecipes.length,
          itemBuilder: (context, index) {
            final recipe = _favoriteRecipes[index];
            return RecipeCard(
              recipe: recipe,
              onTap: () => _navigateToRecipeDetail(recipe),
            );
          },
        );
      },
    );
  }

  void _navigateToRecipeDetail(Recipe recipe) {
    Navigator.pushNamed(
      context,
      '/recipe-detail',
      arguments: recipe.id,
    );
  }
} 