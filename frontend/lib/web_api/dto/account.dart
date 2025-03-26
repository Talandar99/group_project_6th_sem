class AccountDto {
  String email;
  String password;

  AccountDto({required this.email, required this.password});

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    return AccountDto(email: json['email'], password: json['password']);
  }
}
