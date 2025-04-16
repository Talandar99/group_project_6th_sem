
import 'package:flutter/material.dart';

class ProductImageDetails extends StatelessWidget {
  final List<String> imageUrls;
  final int currentPage;
  final PageController controller;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const ProductImageDetails({
    super.key,
    required this.imageUrls,
    required this.currentPage,
    required this.controller,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: controller,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(imageUrls[index], fit: BoxFit.cover),
              );
            },
          ),
        ),
        Positioned(
          left: 8,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: onPrevious,
          ),
        ),
        Positioned(
          right: 8,
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: onNext,
          ),
        ),
      ],
    );
  }
}
