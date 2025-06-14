import 'package:frontend/services/api_connection.dart';
import 'package:frontend/services/cart_service.dart';
import 'package:frontend/services/login_connection.dart';
import 'package:frontend/services/persistant_storage.dart';
import 'package:frontend/services/products_connection.dart';
import 'package:frontend/services/purchase_history_service.dart';
import 'package:get_it/get_it.dart';

void setupDependencyInjection(navigatorKey) {
  GetIt.I.registerLazySingleton<ApiService>(() => ApiService());
  GetIt.I.registerLazySingleton<PersistentStorage>(() => PersistentStorage());
  GetIt.I.registerLazySingleton<UserConnection>(() => UserConnection());
  GetIt.I.registerLazySingleton<ProductsConnection>(() => ProductsConnection());
  GetIt.I.registerLazySingleton<CartService>(() => CartService());
  GetIt.I.registerLazySingleton<PurchaseHistoryService>(() => PurchaseHistoryService());
}
