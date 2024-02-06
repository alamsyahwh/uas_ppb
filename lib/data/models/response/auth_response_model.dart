// To parse this JSON data, do
//
//     final authResponseModel = authResponseModelFromMap(jsonString);

import 'dart:convert';

AuthResponseModel authResponseModelFromMap(String str) =>
    AuthResponseModel.fromMap(json.decode(str));

String authResponseModelToMap(AuthResponseModel data) =>
    json.encode(data.toMap());

class AuthResponseModel {
  String jwtToken;
  User user;

  AuthResponseModel({
    required this.jwtToken,
    required this.user,
  });

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        jwtToken: json["jwt-token"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "jwt-token": jwtToken,
        "user": user.toMap(),
      };

  static fromJson(String jsonString) {}

  String toJson()=> json.encode(toMap());
}

class User {
  int id;
  String name;
  String email;
  String roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roles: json["roles"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "roles": roles,
      };
}
