import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/services/cookies_storage.dart';

class StorageKey {
  late final String key;
  StorageKey({required this.key});
}

class StorageKeys {
  static StorageKey apiToken = StorageKey(key: "apiToken");
  static StorageKey userEmail = StorageKey(key: "userEmail");
  static StorageKey userPassword = StorageKey(key: "userPassword");
}

class PersistentStorage {
  CookiesStorage cookiesStorage = CookiesStorage();
  Future<String?>? getData(StorageKey storageKey) async {
    if (kIsWeb) {
      return cookiesStorage.getData(storageKey);
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? action = prefs.getString(storageKey.key);
      return action;
    }
  }

  Future<void> saveData(StorageKey storageKey, String value) async {
    if (kIsWeb) {
      return cookiesStorage.saveData(storageKey, value);
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(storageKey.key, value);
    }
  }
}
