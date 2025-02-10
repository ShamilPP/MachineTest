import 'package:ecommerce_machinetest/model/product.dart';
import 'package:flutter/material.dart';

import '../../product/product_details_screen.dart';

class SearchProductCard extends StatelessWidget {
  final Product product;

  const SearchProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(product.imageUrl, width: 60, height: 60, fit: BoxFit.contain),
          ),
          title: Text(
            product.title,
            style: TextStyle(fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
          ),
          subtitle: Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
        ),
      ),
    );
  }
}
