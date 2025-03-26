import 'package:frontend/services/api_connection.dart';
import 'package:frontend/services/login_connection.dart';
import 'package:frontend/services/persistant_storage.dart';
import 'package:get_it/get_it.dart';

void setupDependencyInjection(navigatorKey) {
  GetIt.I.registerLazySingleton<ApiService>(() => ApiService());
  GetIt.I.registerLazySingleton<PersistentStorage>(() => PersistentStorage());
  GetIt.I.registerLazySingleton<UserConnection>(() => UserConnection());
}
