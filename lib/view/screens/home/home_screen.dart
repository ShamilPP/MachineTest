import 'package:ecommerce_machinetest/view/screens/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/result.dart';
import '../../../view_model/products_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProductsProvider>(context, listen: false);
      provider.fetchProducts();

      // Scroll listener for pagination
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
          provider.loadMoreProducts();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(builder: (ctx, provider, child) {
      switch (provider.products.status) {
        case ResultStatus.success:
          var products = provider.products.data ?? [];
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductCard(product: products[index]);
                    },
                    childCount: products.length,
                  ),
                ),
              ),
              if (provider.isLoadingMore)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 90),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
            ],
          );
        case ResultStatus.loading:
          return Center(child: CircularProgressIndicator(strokeWidth: 2));
        case ResultStatus.failed:
          return Center(child: Text('Error : ${provider.products.message}'));
        case ResultStatus.idle:
          return const SizedBox();
      }
    });
  }
}
