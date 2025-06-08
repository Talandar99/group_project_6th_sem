import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

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
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                '${amount.toStringAsFixed(2)} zł',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
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
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pop(context, true);
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Anuluj', style: TextStyle(color: Colors.black54)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
