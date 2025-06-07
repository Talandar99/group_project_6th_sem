import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_app_bar.dart';

class CartItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [
    CartItem(
      id: 1,
      name: 'Fotel klasyczny',
      description: 'Wygodny fotel z tkaniny, idealny do salonu.',
      price: 399.99,
      image: 'assets/icons/table.jpg',
      quantity: 2,
    ),
    CartItem(
      id: 2,
      name: 'Stół dębowy',
      description: 'Solidny stół do jadalni, wykonany z drewna dębowego.',
      price: 799.99,
      image: 'assets/icons/table.jpg',
      quantity: 1,
    ),
    CartItem(
      id: 3,
      name: 'Sofa 3-osobowa',
      description: 'Elegancka sofa 3-osobowa, doskonała do salonu.',
      price: 1299.99,
      image: 'assets/icons/table.jpg',
      quantity: 1,
    ),
  ];

  double get totalPrice => cartItems.fold(
      0, (sum, item) => sum + item.price * item.quantity);

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity--;
      if (cartItems[index].quantity <= 0) {
        cartItems.removeAt(index);
      }
    });
  }

  Widget quantitySelector(int index) {
    return Row(
      children: [
        InkWell(
          onTap: () => decreaseQuantity(index),
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: cartItems[index].quantity <= 0 ? Colors.grey[100] : AppColors.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: cartItems[index].quantity <= 0 ? Colors.grey[200]! : Colors.grey[300]!,
              ),
            ),
            child: Icon(
              Icons.remove,
              color: cartItems[index].quantity <= 0 ? Colors.grey[400] : Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '${cartItems[index].quantity}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        InkWell(
          onTap: () => increaseQuantity(index),
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      final int id = args['id'];
      final String name = args['name'];
      final String description = args['description'];
      final double price = args['price'];
      final String image = args['image'];
      final int quantity = args['quantity'];

      final existingIndex = cartItems.indexWhere((item) => item.id == id);
      if (existingIndex >= 0) {
        setState(() {
          cartItems[existingIndex].quantity += quantity;
        });
      } else {
        setState(() {
          cartItems.add(CartItem(
            id: id,
            name: name,
            description: description,
            price: price,
            image: image,
            quantity: quantity,
          ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Koszyk',
        showActions: false,
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: cartItems.isEmpty
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
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
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
                              child: item.image.isNotEmpty
                                  ? Image.asset(
                                      item.image,
                                      fit: BoxFit.contain,
                                    )
                                  : const Icon(Icons.image, color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    item.description,
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
                                        '${(item.price * item.quantity).toStringAsFixed(2)} zł',
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: SafeArea(
                    top: false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: cartItems.isEmpty
                            ? null
                            : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Zamówienie złożone!'),
                                  ),
                                );
                                setState(() {
                                  cartItems.clear();
                                });
                              },
                        child: Text(
                          'Zamów za ${totalPrice.toStringAsFixed(2)} zł',
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