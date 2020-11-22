import 'dart:convert';

import 'package:http/http.dart';
import 'package:tamataSrt/model/%20checkPhoneModel.dart';
import 'package:tamataSrt/model/loginModel.dart';
import 'package:tamataSrt/model/profileModel.dart';
import 'package:tamataSrt/model/provinesModel.dart';
import 'package:tamataSrt/model/regesterModel.dart';

import '../constant.dart';

class AuthRepostary {
  Future<RegesterModelRes> regester(String name, String phone, String password,
      int provId, String address) async {
    final response = await post(baseUrl + "register",
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "name": name,
          "phone": phone,
          "password": password,
          "province_id": provId,
          "address": address
        }));
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegesterModelResFromJson(response.body);
    } else {
      throw Exception("something wrong");
    }
  }

  Future<LoginModelRes> login(String phone, String password) async {
    final response = await post(baseUrl + "login",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"phone": phone, "password": password}));

    if (response.statusCode == 200) {
      return LoginModelResFromJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<ProvinesModel> getProvines() async {
    final response = await get(baseUrl + "provinces");
    if (response.statusCode == 200) {
      return ProvinesModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<ProfileModelRes> getProfile(String token) async {
    final response =
        await get(baseUrl + "profile", headers: {"Authorization": token});

    print(response.statusCode);
    if (response.statusCode == 200) {
      return ProfileModelResFromJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<CheckPhoneModel> sendCodeSms(String token) async {
    final response =
        await post(baseUrl + "verify/send", headers: {"Authorization": token});

    print(response.statusCode);
    if (response.statusCode == 200) {
      return CheckPhoneModelFromJson(response.body);
    } else {
      throw Exception("something wrong");
    }
  }

  Future<CheckPhoneModel> verifyCode(String token, String code) async {
    final response = await post(baseUrl + "verify",
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: json.encode({"code": code}));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return CheckPhoneModelFromJson(response.body);
    } else {
      throw Exception("something wrong");
    }
  }

  Future<CheckPhoneModel> logout(String token) async {
    final response =
        await post(baseUrl + "logout", headers: {"Authorization": token});

    print(response.statusCode);
    if (response.statusCode == 200) {
      return CheckPhoneModelFromJson(response.body);
    } else {
      throw Exception("something wrong");
    }
  }
}
