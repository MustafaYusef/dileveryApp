// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginModelRes LoginModelResFromJson(String str) =>
    LoginModelRes.fromJson(json.decode(str));

class LoginModelRes {
  LoginModelRes({
    this.token,
    this.verified,
    this.role,
  });

  String token;
  bool verified;
  String role;

  factory LoginModelRes.fromJson(Map<String, dynamic> json) => LoginModelRes(
        token: json["token"],
        verified: json["verified"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "verified": verified,
        "role": role,
      };
}
