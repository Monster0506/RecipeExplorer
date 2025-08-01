import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class FavoriteButton extends StatelessWidget {
  final String recipeId;

  const FavoriteButton({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final isFavorite = favoritesProvider.isFavorite(recipeId);
        
        return IconButton(
          onPressed: () async {
            // Add haptic feedback
            HapticFeedback.lightImpact();
            
            // Toggle favorite
            await favoritesProvider.toggleFavorite(recipeId);
            
            // Show feedback
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite ? 'Removed from favorites' : 'Added to favorites',
                  ),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
            size: 28,
          ),
          tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
        );
      },
    );
  }
} 