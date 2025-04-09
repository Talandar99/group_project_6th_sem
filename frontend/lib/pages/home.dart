import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/product_details_page.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/product_tile.dart';
import '../models/product_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ProductModel> _products = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sklep',
        onProfileTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        },
        onBackTap: () {
          // back button if needed?
        },
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
                      : 20, // Wider padding for PC
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: _searchField(),
              ),
              ..._products.map((product) {
                return ProductTile(
                  product: product,
                  onAddCart: () {

                    print('Dodano do koszyka: ${product.name}');
                  },
                  onDetails: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(product: product),
                        ),
                    );
                    print('Szczegóły produktu: ${product.name}');
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }


  Container _searchField() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: AppColors.shadow, blurRadius: 40, spreadRadius: 0),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: 'Szukaj produktów',
          hintStyle: AppTextStyles.hint,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset('assets/icons/Search.svg'),
          ),
          suffixIcon: SizedBox(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VerticalDivider(
                    color: AppColors.divider,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/icons/Filter.svg'),
                  ),
                ],
              ),
            ),
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
