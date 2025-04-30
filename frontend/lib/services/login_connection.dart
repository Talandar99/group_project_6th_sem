import 'dart:convert';

import 'package:frontend/services/api_connection.dart';
import 'package:frontend/services/persistant_storage.dart';
import 'package:frontend/web_api/dto/email_password.dart';
import 'package:frontend/web_api/dto/message.dart';
import 'package:frontend/web_api/dto/token.dart';
import 'package:frontend/web_api/host_ip.dart';
import 'package:get_it/get_it.dart';

class UserConnection {
  final ApiService apiService = GetIt.I<ApiService>();
  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();

  Future<String> register(EmailPasswordDto emailPasswordDto) async {
    var response = await apiService.postWithoutToken(
      '$apiHost/users/register',
      emailPasswordDto,
    );
    var decodedBody = json.decode(response.body);

    print(response.body.toString());
    var message = MessageDto.fromJson(decodedBody);
    return message.message;
  }

  Future<String> login(EmailPasswordDto emailPasswordDto) async {
    var response = await apiService.postWithoutToken(
      '$apiHost/users/login',
      emailPasswordDto,
    );
    if (response.statusCode == 200) {
      var decodedBody = json.decode(response.body);
      var token = TokenDto.fromJson(decodedBody);
      persistentStorage.saveData(StorageKeys.apiToken, token.token.toString());

      //print(response.body.toString());
      //var message = MessageDto.fromJson(decodedBody);
      //change to message
      return token.token;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
