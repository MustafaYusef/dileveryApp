import 'dart:convert';

import 'package:http/http.dart';
import 'package:tamataSrt/model/%20checkPhoneModel.dart';
import 'package:tamataSrt/model/categoryModel.dart';
import 'package:tamataSrt/model/orderDetailsModel.dart';
import 'package:tamataSrt/model/ordersModel.dart';
import 'package:tamataSrt/model/productsModel.dart';
import 'package:tamataSrt/model/provinesModel.dart';
import 'package:tamataSrt/model/sliderModel.dart';
import 'package:tamataSrt/model/vendorModel.dart';

import '../constant.dart';

class MainRepostary {
  Future<SliderResModel> getSlider() async {
    final response = await get(baseUrl + "slider");
    if (response.statusCode == 200) {
      return SliderResModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<CategoryModel> getCategory() async {
    final response = await get(baseUrl + "categories");
    if (response.statusCode == 200) {
      return CategoryModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<VendorsModelRes> getVender(String query) async {
    final response = await get(baseUrl + "vendors?name=$query");
    if (response.statusCode == 200) {
      return VendorsModelResFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<ProductModelRes> getProduct(String query) async {
    final response = await get(baseUrl + "products?name=$query");
    if (response.statusCode == 200) {
      return ProductModelResFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<ProductModelRes> getProductByCategory(int categoryId) async {
    final response = await get(baseUrl + "products?category_id=$categoryId");
    if (response.statusCode == 200) {
      return ProductModelResFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<ProductModelRes> getProductByVendor(int vendorId) async {
    final response = await get(baseUrl + "products?vendor_id=$vendorId");
    if (response.statusCode == 200) {
      return ProductModelResFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<OrdersModelRes> getOrders(String token) async {
    final response = await get(baseUrl + "orders",
        headers: {"Content-Type": "application/json", "Authorization": token});
    if (response.statusCode == 200) {
      return OrdersModelResFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<OrderDetailsModelRes> getOrderDetails(
      String token, int orderId) async {
    final response = await get(baseUrl + "orders/$orderId",
        headers: {"Content-Type": "application/json", "Authorization": token});
    if (response.statusCode == 200) {
      return OrderDetailsModelResFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<CheckPhoneModel> makeOrder(String token, String phone, String address,
      List<OrderObject> products) async {
    print("order");
    print(json.encode(products));
    final response = await post(baseUrl + "orders",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": token
        },
        body: json.encode(
            {"phone": phone, "address": address, "products": products}));
    if (response.statusCode == 200) {
      return CheckPhoneModelFromJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<CheckPhoneModel> updateOrder(
      String token, String action, String note, int orderId) async {
    final response = await put(baseUrl + "orders/$orderId",
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: json.encode({"action": action, "note": note}));
    if (response.statusCode == 200) {
      return CheckPhoneModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }
}

class OrderObject {
  int id;
  int quantity;
  OrderObject(this.id, this.quantity);

  OrderObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}
