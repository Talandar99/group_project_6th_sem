import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/product_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

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
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: imageUrls.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
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
                      onPressed: _previousImage,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onPressed: _nextImage,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(imageUrls.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? AppColors.primary : Colors.grey[300],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 24),
              Text(widget.product.name, style: AppTextStyles.heading),
              SizedBox(height: 8),
              Text('${widget.product.price.toStringAsFixed(2)} zł', style: AppTextStyles.subheading.copyWith(color: AppColors.primary)),
              SizedBox(height: 16),
              Text('Opis', style: AppTextStyles.subheading),
              SizedBox(height: 4),
              Text(widget.product.description, style: AppTextStyles.body),
              SizedBox(height: 24),
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
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _addToCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Do koszyka', style: AppTextStyles.button),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _buyNow,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Kup teraz', style: AppTextStyles.button.copyWith(color: AppColors.primary)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: showSuccess ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Dodano do koszyka', style: TextStyle(color: Colors.green, fontSize: 16)),
                    ],
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
