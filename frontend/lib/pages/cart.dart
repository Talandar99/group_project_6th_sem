import 'package:flutter/material.dart';
import 'package:frontend/services/cart_service.dart';
import 'package:get_it/get_it.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import 'package:frontend/pages/payments.dart';
import 'package:frontend/widgets/custom_snackbar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService cartService = GetIt.I<CartService>();
  Widget quantitySelector(int index) {
    return Row(
      children: [
        InkWell(
          onTap:
              () => setState(() {
                cartService.decreaseItemQuantityAtIndex(index);
              }),
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color:
                  cartService.getItemQuantityAtIndex(index) <= 0
                      ? Colors.grey[100]
                      : AppColors.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color:
                    cartService.getItemQuantityAtIndex(index) <= 0
                        ? Colors.grey[200]!
                        : Colors.grey[300]!,
              ),
            ),
            child: Icon(
              Icons.remove,
              color:
                  cartService.getItemQuantityAtIndex(index) <= 0
                      ? Colors.grey[400]
                      : Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '${cartService.getItemQuantityAtIndex(index)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        InkWell(
          onTap:
              () => setState(() {
                cartService.increaseItemQuantityAtIndex(index);
              }),
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _fakePayment() async {
    final total = cartService.getTotalPrice();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentsPage(amount: total)),
    );
    if (result == true) {
      showCustomSnackBar(context, 'Płatność zakończona sukcesem!');
      setState(() {
        cartService.clearCart();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = cartService.getAllItemsFromCart();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Koszyk',
        showActions: false,
        showAboutUs: false,
      ),
      body:
          cartItems.isEmpty
              ? const Center(
                child: Text(
                  'Twój koszyk jest pusty',
                  style: TextStyle(color: Colors.black),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartService.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 15,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.network(
                                  item.product.imageUrl,
                                  webHtmlElementStrategy:
                                      WebHtmlElementStrategy.prefer,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.productName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      item.product.productName,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        quantitySelector(index),
                                        const Spacer(),
                                        Text(
                                          '${(item.product.price * item.ammount).toStringAsFixed(2)} zł',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          key: const ValueKey('order_for_button'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            if (cartService.getAllItemsAmmount() > 0) {
                              _fakePayment();
                            }
                          },
                          child: Text(
                            'Zamów za ${cartService.getTotalPrice().toStringAsFixed(2)} zł',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
