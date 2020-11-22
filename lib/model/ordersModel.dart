// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

OrdersModelRes OrdersModelResFromJson(String str) =>
    OrdersModelRes.fromJson(json.decode(str));

class OrdersModelRes {
  OrdersModelRes({
    this.orders,
  });

  Orders orders;

  factory OrdersModelRes.fromJson(Map<String, dynamic> json) => OrdersModelRes(
        orders: Orders.fromJson(json["orders"]),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders.toJson(),
      };
}

class Orders {
  Orders({
    this.data,
    this.next,
    this.total,
    this.currentPage,
    this.lastPage,
  });

  List<Datum> data;
  String next;
  int total;
  int currentPage;
  int lastPage;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
      };
}
