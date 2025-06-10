import 'package:flutter/material.dart';
import 'package:frontend/pages/product_details_page.dart';
import 'package:frontend/services/cart_service.dart';
import 'package:frontend/theme/app_text_styles.dart';
import 'package:get_it/get_it.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/product_list.dart';
import 'about_us_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartService cartService = GetIt.I<CartService>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _searchQuery = '';
  @override
  void initState() {
    super.initState();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'WoodSpace',
        style: AppTextStyles.logoText,

        showActions: true,
        allowBack: false,
      ),
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? constraints.maxWidth * 0.2 : 20,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: _searchField(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: ProductList(
                  searchQuerry: _searchQuery,
                  onDetails: (product) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ProductDetailsPage(product: product),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _searchField() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: AppColors.shadow, blurRadius: 40, spreadRadius: 0),
        ],
      ),
      child: TextField(
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: 'Szukaj produktów',
          hintStyle: AppTextStyles.hint,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.search, color: AppColors.iconColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
