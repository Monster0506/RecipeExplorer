# Recipe Explorer

A minimalist and elegant Flutter web application that allows users to browse and view food recipes directly in their web browser. The app integrates with TheMealDB API to fetch recipe data and provides local storage for favorited recipes.

## Features

### ✅ Implemented Requirements

1. **Recipe Browsing**
   - Loads recipes from TheMealDB API with loading indicators
   - Displays recipes in a responsive grid layout
   - Error handling with user-friendly messages and retry functionality

2. **Responsive Design**
   - Mobile: Single column layout (< 600px)
   - Tablet: 2-3 columns (600px - 1200px)
   - Desktop: 3-4 columns (> 1200px)
   - Works across modern web browsers

3. **Recipe Details**
   - Tap/click on recipe cards to view full details
   - Hero animation for smooth transitions
   - Scrollable content with ingredients and instructions
   - Back navigation with AppBar

4. **Favorites System**
   - Heart icon to toggle favorite status
   - Persists favorites in browser localStorage
   - Visual feedback with snackbar notifications
   - Haptic feedback for better UX

5. **API Integration**
   - Proper integration with TheMealDB API
   - Efficient JSON parsing and data handling
   - Network error handling with timeouts
   - Optimized image loading with fallbacks

6. **Modern UI/UX**
   - Clean Material Design 3 theme
   - Orange color scheme for food/appetizing feel
   - Loading states and error recovery
   - Intuitive navigation patterns

## Architecture

The application follows a layered architecture:

```
┌─────────────────────────────────────┐
│           Presentation Layer        │
│  (Screens, Widgets, UI Components)  │
├─────────────────────────────────────┤
│           Business Logic Layer      │
│     (Services, State Management)    │
├─────────────────────────────────────┤
│             Data Layer              │
│   (API Client, Local Storage)       │
└─────────────────────────────────────┘
```

### Key Components

- **Models**: `Recipe` class with JSON serialization
- **Services**: `RecipeService` for API calls, `FavoritesService` for localStorage
- **Providers**: `FavoritesProvider` for global state management
- **Screens**: `RecipeListScreen`, `RecipeDetailScreen`
- **Widgets**: `RecipeCard`, `FavoriteButton`, `ErrorDisplayWidget`

## Getting Started

### Prerequisites

- Flutter SDK (3.7.0 or higher)
- Dart SDK (3.7.0 or higher)
- Web browser (Chrome, Firefox, Safari, Edge)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/monster0506/RecipeExplorer.git recipe_explorer/
cd recipe_explorer
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run -d chrome
```

The app will open in your default browser at `http://localhost:8080`.

### Building for Production

To build the web app for production:

```bash
flutter build web
```

The built files will be in the `build/web` directory.

## API Integration

The app uses TheMealDB API:
- **Base URL**: `https://www.themealdb.com/api/json/v1/1`
- **Endpoints**:
  - Recipe Search: `/search.php?s=` (empty search returns random recipes)
  - Recipe Details: `/lookup.php?i={idMeal}`

## Local Storage

Favorites are stored in browser localStorage using the `shared_preferences` package:
- **Key**: `favorite_recipes`
- **Format**: JSON array of recipe IDs
- **Example**: `["52977", "52978", "52979"]`

## Dependencies

- `flutter`: Core Flutter framework
- `http`: HTTP client for API calls
- `shared_preferences`: Local storage (localStorage on web)
- `provider`: State management
- `cupertino_icons`: iOS-style icons

## Testing

Run the test suite:

```bash
flutter test
```

Run analysis to check for issues:

```bash
flutter analyze
```

## Browser Compatibility

- ✅ Chrome (recommended)
- ✅ Firefox
- ✅ Safari
- ✅ Edge

## Performance Considerations

- Lazy loading for recipe images
- Efficient grid layout with proper aspect ratios
- Optimized API calls with timeouts
- Minimal bundle size with tree-shaking

## Future Enhancements

Potential features for future versions:
- Search functionality
- Recipe categories and filtering
- User accounts and cloud sync
- Recipe sharing
- Cooking timer
- Nutritional information
- Recipe ratings and reviews

## License

This project is licensed under the MIT License.
