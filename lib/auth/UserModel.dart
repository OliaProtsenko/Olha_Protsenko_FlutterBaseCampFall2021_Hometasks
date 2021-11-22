import 'package:flutter/foundation.dart';

class UserModel {
  final String username;
  final String email;
  final String password;
  String userId;

  UserModel({
    @required this.username,
    this.email,
    this.password,
    this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        userId: json["id"].toString(),
        username: json["username"],
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": userId,
        "username": username,
        "password": password,
        "email": email,
      };
}
