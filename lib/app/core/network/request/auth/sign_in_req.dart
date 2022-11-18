import 'dart:convert';

SignInRequest signInRequestFromJson(String source) =>
    SignInRequest.fromJson(json.decode(source));

String signInRequestData(SignInRequest data) => json.encode(data.toJson());

class SignInRequest {
  SignInRequest({required this.email, required this.password});

  String email;
  String password;

  factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
