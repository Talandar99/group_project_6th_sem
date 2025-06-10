import 'package:flutter/material.dart';
import 'package:frontend/services/purchase_history_service.dart';
import 'package:frontend/web_api/dto/purchase_history.dart';
import 'package:get_it/get_it.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_app_bar.dart';

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseHistoryService = GetIt.I<PurchaseHistoryService>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Historia zakupów',
        showActions: false,
        allowBack: true,
        showAboutUs: false,
      ),
      body: FutureBuilder<List<PurchaseHistoryItem>>(
        future: purchaseHistoryService.getPurchaseHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Brak historii zakupów'));
          }
          final history = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              return Padding(
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
                                item.imageUrl,
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
                                    item.productName,
                                    style: AppTextStyles.heading.copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    item.description,
                                    style: AppTextStyles.body.copyWith(
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
                              '${item.price.toStringAsFixed(2)} zł',
                              style: AppTextStyles.button.copyWith(
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
                              item.createdAt,
                              style: AppTextStyles.body.copyWith(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'Ilość: ${item.amountInStock}',
                              style: AppTextStyles.body.copyWith(
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
              );
            },
          );
        },
      ),
    );
  }
}
