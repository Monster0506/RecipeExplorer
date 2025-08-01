class Recipe {
  final String id;
  final String name;
  final String? imageUrl;
  final List<String> ingredients;
  final String instructions;
  final String? category;
  final String? area;

  Recipe({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.ingredients,
    required this.instructions,
    this.category,
    this.area,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    print('🔧 Parsing recipe JSON: $json');
    
    // Parse ingredients by combining strIngredient and strMeasure fields
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add('${measure ?? ''} $ingredient'.trim());
      }
    }

    final recipe = Recipe(
      id: json['idMeal'],
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
      ingredients: ingredients,
      instructions: json['strInstructions'] ?? '',
      category: json['strCategory'],
      area: json['strArea'],
    );
    
    print('✅ Parsed recipe: ${recipe.name} (ID: ${recipe.id})');
    return recipe;
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strMealThumb': imageUrl,
      'strInstructions': instructions,
      'strCategory': category,
      'strArea': area,
    };
  }
} 