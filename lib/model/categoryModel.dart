// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CategoryModel CategoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

class CategoryModel {
  CategoryModel({
    this.categories,
  });

  List<Category> categories;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.icon,
  });

  int id;
  String name;
  String icon;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}
