import 'package:flutter/material.dart';
import 'package:frontend/services/cart_service.dart';
import 'package:frontend/web_api/dto/products.dart';
import 'package:frontend/widgets/custom_alert.dart';
import 'package:frontend/widgets/custom_snackbar.dart';
import 'package:frontend/widgets/page_indicator_dots.dart';
import 'package:get_it/get_it.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/product_action_buttons.dart';
import '../widgets/product_image_details.dart';
import '../widgets/custom_app_bar.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final CartService cartService = GetIt.I<CartService>();
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
    imageUrls = [super.widget.product.imageUrl];
    setState(() {});
  }

  void _incrementQuantity() {
    if (quantity >= widget.product.amountInStock) {
      showAlert('Nie ma już więcej sztuk tego produktu.', context);
      return;
    }
    setState(() {
      cartService.addItemToCart(widget.product);
    });
  }

  void _decrementQuantity() {
    setState(() {
      cartService.removeItemFromCart(widget.product);
    });
  }

  void _addToCart() {
    setState(() {
      cartService.addItemToCart(widget.product);
    });
    setState(() => showSuccess = true);
    Future.delayed(Duration(seconds: 2), () {
      setState(() => showSuccess = false);
    });
  }

  void _buyNow() {
    print('Kup teraz: ${widget.product.productName}, ilość: $quantity');
    showCustomSnackBar(context, 'Dziękujemy za zakup!');
  }

  //void _goToCart() {
  //  Navigator.pushNamed(context, '/cart');
  //}

  void _nextImage() {
    if (_currentPage < imageUrls.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousImage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'Szczegóły produktu', showActions: false),
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
                  child: PageIndicatorDots(
                    pageCount: imageUrls.length,
                    currentPage: _currentPage,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  widget.product.productName,
                  style: AppTextStyles.heading,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  '${widget.product.price.toStringAsFixed(2)} zł',
                  style: AppTextStyles.subheading.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Opis', style: AppTextStyles.subheading),
              ),

              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  widget.product.description,
                  style: AppTextStyles.body,
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ilość:', style: AppTextStyles.body),
                  Row(
                    children: [
                      InkWell(
                        onTap: _decrementQuantity,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color:
                                quantity <= 1
                                    ? Colors.grey[100]
                                    : AppColors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color:
                                  quantity <= 1
                                      ? Colors.grey[200]!
                                      : Colors.grey[300]!,
                            ),
                          ),
                          child: Icon(
                            Icons.remove,
                            color:
                                quantity <= 1 ? Colors.grey[400] : Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          cartService
                              .getItemQuantityByProduct(widget.product)
                              .toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: _incrementQuantity,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 24)),
              ProductActionButtons(onAddToCart: _addToCart, onBuyNow: _buyNow),
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
