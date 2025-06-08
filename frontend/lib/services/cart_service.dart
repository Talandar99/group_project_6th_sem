import 'package:frontend/web_api/dto/products.dart';

class CartItem {
  Product product;
  int ammount;
  CartItem({required this.product, this.ammount = 0});
}

class CartService {
  List<CartItem> cartItems = [];

  void addItemToCart(Product product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (cartItems[index].ammount < product.amountInStock) {
        cartItems[index].ammount += 1;
      }
    } else {
      if (product.amountInStock > 0) {
        cartItems.add(CartItem(product: product, ammount: 1));
      }
    }
  }

  void removeItemFromCart(Product product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (cartItems[index].ammount > 1) {
        cartItems[index].ammount -= 1;
      } else {
        cartItems.removeAt(index);
      }
    }
  }

  void increaseItemQuantityAtIndex(int index) {
    if (index >= 0 && index < cartItems.length) {
      final item = cartItems[index];
      if (item.ammount < item.product.amountInStock) {
        item.ammount += 1;
      }
    }
  }

  void decreaseItemQuantityAtIndex(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].ammount > 1) {
        cartItems[index].ammount -= 1;
      } else {
        cartItems.removeAt(index);
      }
    }
  }

  int getItemQuantityAtIndex(int index) {
    return cartItems[index].ammount;
  }

  int getItemQuantityByProduct(Product product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      return cartItems[index].ammount;
    }
    return 0;
  }

  List<CartItem> getAllItemsFromCart() {
    return cartItems;
  }

  int getAllItemsAmmount() {
    return cartItems.length;
  }

  void clearCart() {
    cartItems = [];
  }

  double getTotalPrice() {
    return cartItems.fold(
      0.0,
      (total, item) => total + (item.product.price * item.ammount),
    );
  }
}
