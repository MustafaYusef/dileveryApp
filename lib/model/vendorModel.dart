// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

VendorsModelRes VendorsModelResFromJson(String str) =>
    VendorsModelRes.fromJson(json.decode(str));

class VendorsModelRes {
  VendorsModelRes({
    this.vendors,
  });

  List<Vendor> vendors;

  factory VendorsModelRes.fromJson(Map<String, dynamic> json) =>
      VendorsModelRes(
        vendors:
            List<Vendor>.from(json["vendors"].map((x) => Vendor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vendors": List<dynamic>.from(vendors.map((x) => x.toJson())),
      };
}

class Vendor {
  Vendor({
    this.id,
    this.name,
    this.address,
    this.province,
    this.image,
    this.createdAt,
  });

  int id;
  String name;
  String address;
  String province;
  String image;
  String createdAt;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        province: json["province"],
        image: json["image"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "province": province,
        "image": image,
        "created_at": createdAt,
      };
}
