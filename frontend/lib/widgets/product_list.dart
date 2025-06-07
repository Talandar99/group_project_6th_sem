import 'package:flutter/cupertino.dart';
import 'package:frontend/services/products_connection.dart';
import 'package:frontend/web_api/dto/products.dart';
import 'package:frontend/widgets/product_tile.dart';
import 'package:get_it/get_it.dart';

class ProductList extends StatefulWidget {
  final List<Product> products;
  final String searchQuerry;
  final void Function(Product) onAddCart;
  final void Function(Product) onDetails;

  const ProductList({
    required this.products,
    required this.onAddCart,
    required this.onDetails,
    required this.searchQuerry,
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductsConnection productsConnection = GetIt.I<ProductsConnection>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productsConnection.getAllProducts(widget.searchQuerry),
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: Text("Connecting"));
          default:
            if (snapshot.hasData) {
              //print(snapshot.data![0].productName);
              return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print(snapshot.data);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ProductTile(
                      product: snapshot.data![index],
                      onAddCart: () => widget.onAddCart(snapshot.data![index]),
                      onDetails: () => widget.onDetails(snapshot.data![index]),
                    ),
                  );
                },
              );
            } else {
              //print(snapshot.toString());
              return Text("Something went wrong ;/");
            }
        }
      },
    );
  }
}
