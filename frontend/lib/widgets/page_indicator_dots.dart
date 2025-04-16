import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PageIndicatorDots extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const PageIndicatorDots({super.key, required this.pageCount, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: currentPage == index ? 12 : 8,
          height: currentPage == index ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? AppColors.primary : Colors.grey[300],
          ),
        );
      }),
    );
  }
}
