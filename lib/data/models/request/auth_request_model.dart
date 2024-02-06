// To parse this JSON data, do
//
//     final authRequestModel = authRequestModelFromMap(jsonString);

import 'dart:convert';

AuthRequestModel authRequestModelFromMap(String str) =>
    AuthRequestModel.fromMap(json.decode(str));

String authRequestModelToMap(AuthRequestModel data) =>
    json.encode(data.toMap());

class AuthRequestModel {
  String email;
  String password;

  AuthRequestModel({
    required this.email,
    required this.password,
  });

  factory AuthRequestModel.fromMap(Map<String, dynamic> json) =>
      AuthRequestModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };

  toJson() {}
}
