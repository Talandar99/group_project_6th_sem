import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/product_details_page.dart';
import 'package:frontend/theme/app_text_styles.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/product_list.dart';
import '../models/product_model.dart';
import '../widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ProductModel> _allProducts = [
    ProductModel(
      id: 1,
      name: 'Fotel klasyczny',
      price: 399.99,
      amount: 10,
      description: 'Wygodny fotel z tkaniny, idealny do salonu.',
    ),
    ProductModel(
      id: 2,
      name: 'Stół dębowy',
      price: 799.99,
      amount: 5,
      description: 'Solidny stół do jadalni, wykonany z drewna dębowego.',
    ),
    ProductModel(
      id: 3,
      name: 'Sofa 3-osobowa',
      price: 1299.99,
      amount: 3,
      description: 'Elegancka sofa 3-osobowa, doskonała do salonu.',
    ),
  ];

  List<ProductModel> _products = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _products = List.from(_allProducts);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _products = _allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sklep',
        onProfileTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        showActions: true,
        onBackTap: null,
      ),
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal:
                  isWideScreen
                      ? constraints.maxWidth * 0.2
                      : 20,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: _searchField(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: ProductList(
                  products: _products,
                  onAddCart: (product) {},
                  onDetails: (product) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(product: product),
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
