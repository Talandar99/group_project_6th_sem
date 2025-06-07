import 'package:flutter/material.dart';
import 'package:frontend/web_api/dto/products.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_button.dart';
import 'custom_outlined_button.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onAddCart;
  final VoidCallback onDetails;

  const ProductTile({
    super.key,
    required this.product,
    required this.onAddCart,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Center(
                child: Image.network(
                  product.imageUrl,
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(product.productName, style: AppTextStyles.subheading),
          const Padding(padding: EdgeInsets.only(top: 5)),
          Text(
            '${product.price.toStringAsFixed(2)} zł',
            style: AppTextStyles.body,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            children: [
              Expanded(
                child: CustomButton(text: 'Do koszyka', onPressed: onAddCart),
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              Expanded(
                child: CustomOutlinedButton(
                  text: 'Szczegóły',
                  onPressed: onDetails,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
