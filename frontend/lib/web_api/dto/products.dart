class ProductsDto {
  bool success;
  int count;
  List<Product> data;

  ProductsDto(this.success, this.count, this.data);

  static ProductsDto fromJson(Map<String, dynamic> json) {
    var list = <Product>[];
    for (var item in json['data']) {
      list.add(Product.fromJson(item));
    }
    return ProductsDto(json['success'], json['count'], list);
  }
}

class Product {
  int id;
  String productName;
  double price;
  int amountInStock;
  String description;
  String imageUrl;

  Product(
    this.id,
    this.productName,
    this.price,
    this.amountInStock,
    this.description,
    this.imageUrl,
  );

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['product_name'],
      double.parse(json['price'].toString()),
      json['amount_in_stock'],
      json['description'],
      json['image_url'],
    );
  }
}
