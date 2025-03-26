import 'dto_to_json_interface.dart';

class EmailPasswordDto implements DtoToJsonInterface {
  String email;
  String password;

  EmailPasswordDto({required this.email, required this.password});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['email'] = email;
    data['password'] = password;

    return data;
  }
}
