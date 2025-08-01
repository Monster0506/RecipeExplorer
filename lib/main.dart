import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/recipe_list_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/recipe_detail_screen.dart';

void main() {
  runApp(const RecipeExplorerApp());
}

class RecipeExplorerApp extends StatelessWidget {
  const RecipeExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesProvider()..loadFavorites()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Recipe Explorer',
            theme: themeProvider.currentTheme,
            initialRoute: '/',
            routes: {
              '/': (context) => const RecipeListScreen(),
              '/favorites': (context) => const FavoritesScreen(),
              '/recipe-detail': (context) => RecipeDetailScreen(
                    recipeId: ModalRoute.of(context)!.settings.arguments as String,
                  ),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
