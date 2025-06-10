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
  static StorageKey userId = StorageKey(key: "userId");
}

class PersistentStorage {
  CookiesStorage cookiesStorage = CookiesStorage();
  Future<String>? getData(StorageKey storageKey) async {
    if (kIsWeb) {
      var value = cookiesStorage.getData(storageKey);
      if (value == null) {
        value = "";
      }
      return value;
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(storageKey.key);
      if (value == null) {
        value = "";
      }
      return value;
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
