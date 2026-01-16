class ApiConstants {
  static const String baseUrl = 'http://192.168.137.251:8000/api/';
  static const String baseImageUrl = 'http://192.168.137.251:8000';
  static const String apiKey =
      '05abfc2a59fb530d1db8c9b4fa89729f1121efb2b32d44badac9a7b5b98940a2';
  static const String recipesEndpoint = 'recipes';
  static const String cuisinesEndpoint = 'cuisines';
  static const String categoriesEndpoint = 'categories';
  static const String featuredRecipesEndpoint = 'recipes/featured';
  static const String popularRecipesEndpoint = 'recipes/popular';

  // Helper to get recipe by ID endpoint
  static String getRecipeByIdEndpoint(String id) => 'recipes/$id';

  // Helper to convert relative image URLs to full URLs
  static String getFullImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return '';
    
    // If already a full URL, return as is
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return imageUrl;
    }
    
    // If starts with /, prepend base URL
    if (imageUrl.startsWith('/')) {
      return '$baseImageUrl$imageUrl';
    }
    
    // Otherwise, assume it's a relative path
    return '$baseImageUrl/$imageUrl';
  }
}
