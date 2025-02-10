import 'package:ecommerce_machinetest/view/screens/search/widgets/search_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/result.dart';
import '../../../view_model/products_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false).clearSearchResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onChanged: (value) {
              Provider.of<ProductsProvider>(context, listen: false).searchProduct(value);
            },
          ),
        ),
      ),
      body: Consumer<ProductsProvider>(
        builder: (ctx, provider, child) {
          switch (provider.searchProducts.status) {
            case ResultStatus.success:
              var products = provider.searchProducts.data ?? [];

              if (products.isNotEmpty) {
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return SearchProductCard(product: product);
                  },
                );
              } else {
                return Center(child: Text('Item not found'));
              }
            case ResultStatus.loading:
              return Center(child: CircularProgressIndicator(strokeWidth: 2));
            case ResultStatus.failed:
              return Center(child: Text('Error : ${provider.searchProducts.message}'));
            case ResultStatus.idle:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
