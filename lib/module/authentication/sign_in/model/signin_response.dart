import 'dart:convert';

class SignInResponse {
  String email;
  String password;

  SignInResponse({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
