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
    String? userId = await persistentStorage.getData(StorageKeys.userId);
    var response = await apiService.makeApiGetRequest(
      '$apiHost/purchase_history?user_id=$userId',
    );
    var decodedBody = json.decode(response.body);
    PurchaseHistoryDto decodedResponse = PurchaseHistoryDto.fromJson(
      decodedBody,
    );
    return decodedResponse.data;
  }

  //Future<List<Product>> getAllProducts(String searchQuerry) async {
  //  var response = await apiService.makeApiGetRequest(
  //    '$apiHost/products/?page=1&limit=10&s=$searchQuerry',
  //  );
  //  var decodedBody = json.decode(response.body);

  //  //print(response.body.toString());
  //  ProductsDto decodedResponse = ProductsDto.fromJson(decodedBody);
  //  print(decodedResponse.data[0].imageUrl);

  //  return decodedResponse.data;
  //}
}

