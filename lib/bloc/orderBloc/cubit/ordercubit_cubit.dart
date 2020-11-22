import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamataSrt/model/orderDetailsModel.dart';
import 'package:tamataSrt/model/ordersModel.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:tamataSrt/ui/odersScreen.dart';
import 'package:toast/toast.dart';

part 'ordercubit_state.dart';

class OrdercubitCubit extends Cubit<OrdercubitState> {
  final MainRepostary repo;
  OrdercubitCubit(this.repo) : super(OrdercubitLoading());

  Future<void> GetOrders(BuildContext context) async {
    emit(OrdercubitLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = await prefs.get('token');

      final resources = await repo.getOrders(token);
      emit(OrdercubitLoaded(resources));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(OrdercubitNetworkError());

    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(OrdercubitError(_.toString()));
    }
  }

  Future<void> getOrderDetails(BuildContext context, int orderId) async {
    emit(OrdercubitLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = await prefs.get('token');
      final role = await prefs.get('role');
      final resources = await repo.getOrderDetails(token, orderId);
      emit(OrdercubitDetailsLoaded(resources, role));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //emit(OrdercubitNetworkError());
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //  emit(OrdercubitError(_.toString()));
    }
  }

  Future<void> updateOrder(
      BuildContext context, String action, String note, int orderId) async {
    emit(OrdercubitLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = await prefs.get('token');

      final resources = await repo.updateOrder(token, action, note, orderId);

      Toast.show("update succecfully", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return OrdersScreen();
      }));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(OrdercubitNetworkError());
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(OrdercubitError(_.toString()));
    }
  }

  // Future<void> makeOrder(BuildContext context, String phone, String address,
  //     List<OrderObject> products) async {
  //   emit(OrdercubitLoading());

  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();

  //     final token = await prefs.get('token');

  //     final resources = await repo.makeOrder(token, phone, address, products);

  //     Toast.show("created succecfully", context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   } on SocketException catch (_) {
  //     Toast.show("There is no internet connection", context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //     emit(OrdercubitNetworkError());
  //   } catch (_) {
  //     Toast.show(_.toString(), context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //     emit(OrdercubitError(_.toString()));
  //   }
  // }
}
