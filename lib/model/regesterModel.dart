// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

RegesterModelRes RegesterModelResFromJson(String str) =>
    RegesterModelRes.fromJson(json.decode(str));

class RegesterModelRes {
  RegesterModelRes({
    this.token,
  });

  String token;

  factory RegesterModelRes.fromJson(Map<String, dynamic> json) =>
      RegesterModelRes(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
