class PurchaseHistoryDto {
  bool success;
  int count;
  List<PurchaseHistoryItem> data;

  PurchaseHistoryDto(this.success, this.count, this.data);

  static PurchaseHistoryDto fromJson(Map<String, dynamic> json) {
    var list = <PurchaseHistoryItem>[];
    for (var item in json['data']) {
      list.add(PurchaseHistoryItem.fromJson(item));
    }
    return PurchaseHistoryDto(json['success'], json['count'], list);
  }
}

class PurchaseHistoryItem {
  int id;
  String productName;
  double price;
  int amountInStock;
  String description;
  String imageUrl;
  int userId;
  String createdAt;

  PurchaseHistoryItem(
    this.id,
    this.productName,
    this.price,
    this.amountInStock,
    this.description,
    this.imageUrl,
    this.userId,
    this.createdAt,
  );

  static PurchaseHistoryItem fromJson(Map<String, dynamic> json) {
    return PurchaseHistoryItem(
      json['id'],
      json['product_name'],
      double.parse(json['price'].toString()),
      json['amount_in_stock'],
      json['description'],
      json['image_url'],
      json['user_id'],
      json['created_at'],
    );
  }
}