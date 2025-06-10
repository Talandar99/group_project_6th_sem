import 'package:shared_preferences/shared_preferences.dart';

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
  getData(StorageKey storageKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(storageKey.key);
    return action;
  }

  saveData(StorageKey storageKey, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey.key, value);
  }
  removeData(StorageKey storageKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(storageKey.key);
  }

}
