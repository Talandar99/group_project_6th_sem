import 'dart:convert';

import 'package:frontend/services/api_connection.dart';
import 'package:frontend/services/persistant_storage.dart';
import 'package:frontend/web_api/dto/email_password.dart';
import 'package:frontend/web_api/dto/token.dart';
import 'package:frontend/web_api/host_ip.dart';
import 'package:get_it/get_it.dart';

class LoginConnectionService {
  final ApiService apiService = GetIt.I<ApiService>();
  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();

  Future<TokenDto> login(EmailPasswordDto emailPasswordDto) async {
    var response = await apiService.postWithoutToken(
      '$apiHost/users/login',
      emailPasswordDto,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var decodedBody = json.decode(response.body);

      print("-----------------------------------------");
      print(response.body.toString());
      print("-----------------------------------------");
      var token = TokenDto.fromJson(decodedBody);
      persistentStorage.saveData(StorageKeys.apiToken, token.token.toString());

      return TokenDto.fromJson(decodedBody);
    } else {
      throw Exception("wrong credentials");
    }
  }
}
