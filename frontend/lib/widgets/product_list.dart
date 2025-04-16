import 'package:flutter/cupertino.dart';
import 'package:frontend/widgets/product_tile.dart';

import '../models/product_model.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel> products;
  final void Function(ProductModel) onAddCart;
  final void Function(ProductModel) onDetails;

  const ProductList({
    required this.products,
    required this.onAddCart,
    required this.onDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final product = products[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ProductTile(
            product: product,
            onAddCart: () => onAddCart(product),
            onDetails: () => onDetails(product),
          ),
        );
      },
    );
  }
}
