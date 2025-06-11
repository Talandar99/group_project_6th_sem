import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PaymentsPage extends StatelessWidget {
  final double amount;
  const PaymentsPage({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Płatność'),
        backgroundColor: AppColors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.credit_card, size: 80, color: AppColors.primary),
              const SizedBox(height: 24),
              Text(
                'Do zapłaty:',
                style: AppTextStyles.paymentLabel,
              ),
              const SizedBox(height: 8),
              Text(
                '${amount.toStringAsFixed(2)} zł',
                style: AppTextStyles.paymentAmount,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                key: const ValueKey('pay_button'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: const Text(
                  'Zapłać',
                  style: AppTextStyles.paymentButton,
                ),
                onPressed: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pop(context, true);
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Anuluj', style: AppTextStyles.paymentCancel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
