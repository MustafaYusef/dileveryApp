// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CheckPhoneModel CheckPhoneModelFromJson(String str) =>
    CheckPhoneModel.fromJson(json.decode(str));

class CheckPhoneModel {
  CheckPhoneModel({
    this.message,
  });

  String message;

  factory CheckPhoneModel.fromJson(Map<String, dynamic> json) =>
      CheckPhoneModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
