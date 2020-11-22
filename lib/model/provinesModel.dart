// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProvinesModel ProvinesModelFromJson(String str) =>
    ProvinesModel.fromJson(json.decode(str));

class ProvinesModel {
  ProvinesModel({
    this.provinces,
  });

  List<Province> provinces;

  factory ProvinesModel.fromJson(Map<String, dynamic> json) => ProvinesModel(
        provinces: List<Province>.from(
            json["provinces"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "provinces": List<dynamic>.from(provinces.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
