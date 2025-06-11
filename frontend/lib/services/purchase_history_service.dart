import 'dart:convert';
import 'package:frontend/services/api_connection.dart';
import 'package:frontend/services/persistant_storage.dart';
import 'package:frontend/web_api/dto/purchase_history.dart';
import 'package:frontend/web_api/host_ip.dart';
import 'package:get_it/get_it.dart';

class PurchaseHistoryService {
  final ApiService apiService = GetIt.I<ApiService>();
  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();


Future<List<PurchaseHistoryItem>> getPurchaseHistory() async {
    // Tymczasowe dane testowe
    return [
      PurchaseHistoryItem(
        1,
        'Stół dębowy',
        1299.99,
        1,
        'Solidny stół do jadalni, wykonany z litego drewna dębowego.',
        'https://picsum.photos/id/1011/200/200',
        1,
        '2024-06-01 12:34',
      ),
      PurchaseHistoryItem(
        2,
        'Sofa 3-osobowa',
        2199.00,
        1,
        'Nowoczesna sofa 3-osobowa z funkcją spania i pojemnikiem na pościel.',
        'https://picsum.photos/id/1012/200/200',
        1,
        '2024-05-15 09:10',
      ),
      PurchaseHistoryItem(
        3,
        'Fotel klasyczny',
        799.50,
        2,
        'Wygodny fotel tapicerowany, idealny do salonu lub gabinetu.',
        'https://picsum.photos/id/1013/200/200',
        1,
        '2024-04-20 17:45',
      ),
      PurchaseHistoryItem(
        4,
        'Regał na książki',
        499.99,
        1,
        'Pojemny regał na książki z półkami o regulowanej wysokości.',
        'https://picsum.photos/id/1014/200/200',
        1,
        '2024-03-10 14:22',
      ),
    ];
    // KONIEC danych testowych


  // Future<List<PurchaseHistoryItem>> getPurchaseHistory() async {
  //   String? userId = await persistentStorage.getData(StorageKeys.userId);
  //   var response = await apiService.makeApiGetRequest(
  //     '$apiHost/purchase_history?user_id=$userId',
  //   );
  //   var decodedBody = json.decode(response.body);
  //   PurchaseHistoryDto decodedResponse = PurchaseHistoryDto.fromJson(
  //     decodedBody,
  //   );
  //   return decodedResponse.data;
  // }

  //Future<List<Product>> getAllProducts(String searchQuerry) async {
  //  var response = await apiService.makeApiGetRequest(
  //    '$apiHost/products/?page=1&limit=10&s=$searchQuerry',
  //  );
  //  var decodedBody = json.decode(response.body);

  //  //print(response.body.toString());
  //  ProductsDto decodedResponse = ProductsDto.fromJson(decodedBody);
  //  print(decodedResponse.data[0].imageUrl);

  //  return decodedResponse.data;
  }
}

