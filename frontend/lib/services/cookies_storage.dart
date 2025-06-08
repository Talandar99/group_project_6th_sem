import 'dart:io';

import 'package:frontend/services/persistant_storage.dart';

class CookiesStorage {
  final Map<String, Cookie> _cookies = {};

  String? getData(StorageKey storageKey) {
    final cookie = _cookies[storageKey.key];
    return cookie?.value;
  }

  void saveData(StorageKey storageKey, String value) {
    final cookie = Cookie(storageKey.key, value);
    _cookies[storageKey.key] = cookie;
  }
}
