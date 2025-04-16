import 'package:flutter/material.dart';
import 'package:frontend/widgets/page_indicator_dots.dart';
import '../models/product_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/product_action_buttons.dart';
import '../widgets/product_image_details.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}
class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  List<String> imageUrls = [];
  late PageController _pageController;
  int _currentPage = 0;
  bool showSuccess = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadProductImages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _loadProductImages() {
    imageUrls = [
      'https://picsum.photos/id/${widget.product.id * 10 + 1}/600/400',
      'https://picsum.photos/id/${widget.product.id * 10 + 2}/600/400',
      'https://picsum.photos/id/${widget.product.id * 10 + 3}/600/400',
    ];
    setState(() {});
  }

  void _incrementQuantity() {
    if (quantity >= widget.product.amount) {
      _showAlert('Nie ma już więcej sztuk tego produktu.');
      return;
    }
    setState(() => quantity++);
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() => quantity--);
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Uwaga'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _addToCart() {
    print('Dodano do koszyka: ${widget.product.name}, ilość: $quantity');
    setState(() => showSuccess = true);
    Future.delayed(Duration(seconds: 2), () {
      setState(() => showSuccess = false);
    });
  }

  void _buyNow() {
    print('Kup teraz: ${widget.product.name}, ilość: $quantity');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Dziękujemy za zakup!')));
  }

  void _goToCart() {
    Navigator.pushNamed(context, '/cart');
  }

  void _nextImage() {
    if (_currentPage < imageUrls.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void _previousImage() {
    if (_currentPage > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Szczegóły produktu', style: AppTextStyles.subheading),
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: AppColors.primary),
            onPressed: _goToCart,
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProductImageDetails(
                imageUrls: imageUrls,
                currentPage: _currentPage,
                controller: _pageController,
                onNext: _nextImage,
                onPrevious: _previousImage,
              ),

              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Center(
                  child: PageIndicatorDots(pageCount: imageUrls.length, currentPage: _currentPage),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(widget.product.name, style: AppTextStyles.heading),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  '${widget.product.price.toStringAsFixed(2)} zł',
                  style: AppTextStyles.subheading.copyWith(color: AppColors.primary),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Opis', style: AppTextStyles.subheading),
              ),

              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(widget.product.description, style: AppTextStyles.body),
              ),

              Padding(
                padding: EdgeInsets.only(top: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ilość:', style: AppTextStyles.body),
                  Row(
                    children: [
                      IconButton(onPressed: _decrementQuantity, icon: Icon(Icons.remove_circle_outline)),
                      Text(quantity.toString(), style: AppTextStyles.body),
                      IconButton(onPressed: _incrementQuantity, icon: Icon(Icons.add_circle_outline)),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 24),
              ),
              ProductActionButtons(
                onAddToCart: _addToCart,
                onBuyNow: _buyNow,
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
                child: AnimatedOpacity(
                  opacity: showSuccess ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Dodano do koszyka',
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
