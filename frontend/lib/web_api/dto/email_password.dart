import 'dto_to_json_interface.dart';

class EmailPasswordDto implements DtoToJsonInterface {
  String email;
  String password;

  EmailPasswordDto({required this.email, required this.password});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (email.isNotEmpty) {
      data['email'] = email;
    } else {
      print("email is empty");
    }

    if (password.isNotEmpty) {
      data['password'] = password;
    } else {
      print("password is empty");
    }
    return data;
  }
}
