import 'package:ecommerce_machinetest/model/product.dart';
import 'package:ecommerce_machinetest/services/product_service.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../model/result.dart';

class ProductsProvider with ChangeNotifier {
  int _limit = AppConstants.paginationLimit;
  bool isLoadingMore = false; // To prevent duplicate requests

  Result<List<Product>> _products = Result.initial();

  Result<List<Product>> get products => _products;

  Result<List<Product>> _searchProducts = Result.initial();

  Result<List<Product>> get searchProducts => _searchProducts;

  /// Fetch initial products
  fetchProducts() async {
    _limit = AppConstants.paginationLimit;
    _products.setStatus(ResultStatus.loading);
    notifyListeners();

    try {
      var result = await ProductService.getProductsWithLimit(_limit);
      _products = result;
    } catch (e) {
      _products = Result.error(e.toString());
    }
    notifyListeners();
  }

  /// Load more products while keeping existing ones
  loadMoreProducts() async {
    if (isLoadingMore || _products.status == ResultStatus.loading) return;
    // Increase by 8
    _limit = _limit + AppConstants.paginationLimit;
    isLoadingMore = true;
    notifyListeners();

    try {
      var result = await ProductService.getProductsWithLimit(_limit);
      if (result.data != null && result.data!.isNotEmpty) {
        _products = result;
      }
    } catch (e) {
      _products = Result.error(e.toString());
    }

    isLoadingMore = false;
    notifyListeners();
  }

  searchProduct(String text) {
    if (text.isEmpty) {
      _searchProducts = _products;
    } else {
      var filteredProducts = _products.data?.where((product) => product.title.toLowerCase().contains(text.toLowerCase())).toList();
      _searchProducts = Result.success(filteredProducts ?? []);
    }
    notifyListeners();
  }

  void clearSearchResult() {
    _searchProducts = _products;
  }
}
