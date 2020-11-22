// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProfileModelRes ProfileModelResFromJson(String str) =>
    ProfileModelRes.fromJson(json.decode(str));

class ProfileModelRes {
  ProfileModelRes({
    this.user,
  });

  User user;

  factory ProfileModelRes.fromJson(Map<String, dynamic> json) =>
      ProfileModelRes(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  User({
    this.name,
    this.phone,
    this.role,
    this.address,
    this.createdAt,
  });

  String name;
  String phone;
  String role;
  dynamic address;
  String createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        phone: json["phone"],
        role: json["role"],
        address: json["address"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "role": role,
        "address": address,
        "created_at": createdAt,
      };
}
