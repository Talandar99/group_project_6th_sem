import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/cart_service.dart';
import 'package:frontend/services/products_connection.dart';
import 'package:frontend/web_api/dto/products.dart';
import 'package:frontend/widgets/product_tile.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatefulWidget {
  final String searchQuerry;
  final void Function(Product) onDetails;

  const ProductList({
    required this.onDetails,
    required this.searchQuerry,
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductsConnection productsConnection = GetIt.I<ProductsConnection>();
  final CartService cartService = GetIt.I<CartService>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productsConnection.getAllProducts(widget.searchQuerry),
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return SizedBox(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 448,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // Zaokrąglone rogi
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 448,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // Zaokrąglone rogi
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            if (snapshot.hasData) {
              //print(snapshot.data![0].productName);
              return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ProductTile(
                      product: snapshot.data![index],
                      onDetails: () => widget.onDetails(snapshot.data![index]),
                    ),
                  );
                },
              );
            } else {
              return Text("");
            }
        }
      },
    );
  }
}
