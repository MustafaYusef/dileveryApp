import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamataSrt/database/database.dart';
import 'package:tamataSrt/main.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:tamataSrt/ui/authUi/loginScreen.dart';
import 'package:tamataSrt/ui/cartScreen.dart';
import 'package:tamataSrt/ui/odersScreen.dart';
import 'package:toast/toast.dart';

part 'cartcubite_state.dart';

class CartcubiteCubit extends Cubit<CartcubiteState> {
  final MainRepostary repo;
  List<ItemLocal> items;
  CartcubiteCubit(this.repo) : super(CartcubiteInitial());
  Box _personBox;
  Future<void> addCart(BuildContext context, ItemLocal item) async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ItemLocalAdapter());
    }

    _personBox = await Hive.openBox('itemBox');

    try {
      // ItemLocal item1 = _personBox.getAt(item.itemId) as ItemLocal;

      // _personBox.deleteAt(0);
      // print(item1.name);
      _personBox.put(item.itemId, item);

      Toast.show("added success", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (_) {
      // _personBox.add(item);
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<void> deleteItem(BuildContext context, int index) async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ItemLocalAdapter());
    }

    _personBox = await Hive.openBox('itemBox');

    try {
      _personBox.delete(index);

      Toast.show("delet", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      //   return CartScreen();
      // }));
      items = _personBox.values.toList().cast<ItemLocal>();

      emit(CartLoaded(items, false));
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<void> getCart(BuildContext context) async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ItemLocalAdapter());
    }

    _personBox = await Hive.openBox('itemBox');

    try {
      items = _personBox.values.toList().cast<ItemLocal>();

      emit(CartLoaded(items, false));
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<void> makeOrder(BuildContext context, String phone, String address,
      List<OrderObject> products) async {
    emit(CartLoaded(items, true));

    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ItemLocalAdapter());
    }

    _personBox = await Hive.openBox('itemBox');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = await prefs.getString('token');
      if (token == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return LoginScreen();
        }));
      }
      final resources = await repo.makeOrder(token, phone, address, products);
      _personBox.deleteAll(_personBox.keys);
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Main(3);
      }));
      Toast.show("created succecfully", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
