class ApiEndpoints {
  static const String baseUrl = 'https://fakestoreapi.com';

  static String getProductsWithLimit(int limit) {
    return '$baseUrl/products?limit=$limit';
  }
}
