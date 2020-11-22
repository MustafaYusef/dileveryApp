// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

OrderDetailsModelRes OrderDetailsModelResFromJson(String str) =>
    OrderDetailsModelRes.fromJson(json.decode(str));

class OrderDetailsModelRes {
  OrderDetailsModelRes({
    this.order,
  });

  Order order;

  factory OrderDetailsModelRes.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModelRes(
        order: Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.status,
    this.customer,
    this.vendor,
    this.driver,
    this.totalPrice,
    this.discount,
    this.deliveryPrice,
    this.finalPrice,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  int id;
  String status;
  String customer;
  String vendor;
  String driver;
  String totalPrice;
  String discount;
  String deliveryPrice;
  String finalPrice;
  dynamic notes;
  String createdAt;
  String updatedAt;
  List<Product> products;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        status: json["status"],
        customer: json["customer"],
        vendor: json["vendor"],
        driver: json["driver"],
        totalPrice: json["total_price"],
        discount: json["discount"],
        deliveryPrice: json["delivery_price"],
        finalPrice: json["final_price"],
        notes: json["notes"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "customer": customer,
        "vendor": vendor,
        "driver": driver,
        "total_price": totalPrice,
        "discount": discount,
        "delivery_price": deliveryPrice,
        "final_price": finalPrice,
        "notes": notes,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.images,
    this.vendor,
    this.category,
    this.price,
    this.published,
    this.createdAt,
    this.quantity,
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
  int quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        vendor: json["vendor"],
        category: json["category"],
        price: json["price"],
        published: json["published"],
        createdAt: json["created_at"],
        quantity: json["quantity"],
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
        "quantity": quantity,
      };
}
