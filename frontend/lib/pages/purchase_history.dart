import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_app_bar.dart';

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({super.key});

  // przykladowe 
  final List<Map<String, dynamic>> _history = const [
    {
      'product_name': 'Fotel klasyczny',
      'price': 399.99,
      'amount_in_stock': 1,
      'description': 'Wygodny fotel z tkaniny, idealny do salonu ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss.',
      'image_url': 'assets/icons/table.jpg',
      'created_at': '2024-06-01 12:34',
    },
    {
      'product_name': 'Stół dębowy',
      'price': 799.99,
      'amount_in_stock': 1,
      'description': 'Solidny stół do jadalni, wykonany z drewna dębowego.',
      'image_url': 'assets/icons/table.jpg',
      'created_at': '2024-06-02 15:20',
    },
    {
      'product_name': 'Sofa 3-osobowa',
      'price': 1299.99,
      'amount_in_stock': 2,
      'description': 'Elegancka sofa 3-osobowa, doskonała do salonu.',
      'image_url': 'assets/icons/table.jpg',
      'created_at': '2024-06-03 09:10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Historia zakupów',
        showActions: false,
        allowBack: true,
        showAboutUs: false,
      ),
      body: _history.isEmpty
          ? const Center(child: Text('Brak historii zakupów'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ..._history.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item['image_url'],
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['product_name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      item['description'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${item['price'].toStringAsFixed(2)} zł',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item['created_at'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Ilość: ${item['amount_in_stock']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
    );
  }
}
