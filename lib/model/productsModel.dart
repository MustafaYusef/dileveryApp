// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProductModelRes ProductModelResFromJson(String str) =>
    ProductModelRes.fromJson(json.decode(str));

class ProductModelRes {
  ProductModelRes({
    this.products,
  });

  Products products;

  factory ProductModelRes.fromJson(Map<String, dynamic> json) =>
      ProductModelRes(
        products: Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "products": products.toJson(),
      };
}

class Products {
  Products({
    this.data,
    this.next,
    this.total,
    this.currentPage,
    this.lastPage,
  });

  List<Datum> data;
  dynamic next;
  int total;
  int currentPage;
  int lastPage;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        next: json["next"],
        total: json["total"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "next": next,
        "total": total,
        "current_page": currentPage,
        "last_page": lastPage,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.description,
    this.images,
    this.vendor,
    this.category,
    this.price,
    this.published,
    this.createdAt,
  });

  int id;
  String name;
  String description;
  List<String> images;
  String vendor;
  String category;
  String price;
  bool published;
  String createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        vendor: json["vendor"],
        category: json["category"],
        price: json["price"],
        published: json["published"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "vendor": vendor,
        "category": category,
        "price": price,
        "published": published,
        "created_at": createdAt,
      };
}
