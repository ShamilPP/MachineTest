import 'package:ecommerce_machinetest/model/product.dart';

import '../../../model/result.dart';
import '../../../utils/api_endpoints.dart';
import 'api_service.dart';

class ProductService {
  static final ApiService apiService = ApiService();

  static Future<Result<List<Product>>> getProductsWithLimit(int limit) async {
    final result = await apiService.get(ApiEndpoints.getProductsWithLimit(limit));
    if (result.status == ResultStatus.success) {
      List<Product> products = [];
      for (var item in result.data!) {
        Product _product = Product.fromJson(item);
        products.add(_product);
      }
      return Result.success(products);
    } else {
      return Result.error(result.message);
    }
  }
}
