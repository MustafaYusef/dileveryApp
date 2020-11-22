import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamataSrt/model/categoryModel.dart';
import 'package:tamataSrt/model/productsModel.dart';
import 'package:tamataSrt/model/profileModel.dart';
import 'package:tamataSrt/model/sliderModel.dart';
import 'package:tamataSrt/model/vendorModel.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:toast/toast.dart';

part 'maincubite_state.dart';

class MaincubiteCubit extends Cubit<MaincubiteState> {
  CategoryModel categoryData;
  final MainRepostary repo;
  MaincubiteCubit(this.repo) : super(MaincubiteInitial());

  Future<void> getMain(BuildContext context) async {
    emit(MaincubiteLoading());
    print("call main");
    try {
      final slider = await repo.getSlider();
      emit(MaincubitLoaded(slider, null, null, null));
      final category = await repo.getCategory();
      emit(MaincubitLoaded(slider, category, null, null));

      final vendors = await repo.getVender("");
      emit(MaincubitLoaded(slider, category, vendors, null));

      final products = await repo.getProduct("");
      emit(MaincubitLoaded(slider, category, vendors, products));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //  emit(MaincubiteNetworkError());
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //emit(MaincubiteError(_.toString()));
    }
  }

  Future<void> searchMain(BuildContext context, String query) async {
    emit(MaincubiteLoading());

    try {
      final products = await repo.getProduct(query);
      emit(MaincubitSearchProduct(products));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(MaincubiteNetworkError());
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(MaincubiteError(_.toString()));
    }
  }

  Future<void> getVendors(BuildContext context, String query) async {
    emit(MaincubiteLoading());
    print("method call");
    try {
      final products = await repo.getVender(query);
      emit(MaincubitVendorScreenLoaded(products));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(MaincubiteNetworkError());
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(MaincubiteError(_.toString()));
    }
  }

  Future<void> getProductScreen(BuildContext context, int id) async {
    emit(MaincubiteLoading());

    try {
      if (categoryData == null) {
        final category = await repo.getCategory();
        categoryData = category;
      }

      emit(MainCubiteProductAndSection(categoryData, null));
      if (id == 0) {
        final products =
            await repo.getProductByCategory(categoryData.categories[0].id);
        emit(MainCubiteProductAndSection(categoryData, products));
      } else {
        final products = await repo.getProductByCategory(id);
        emit(MainCubiteProductAndSection(categoryData, products));
      }
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(MaincubiteNetworkError());
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(MaincubiteError(_.toString()));
    }
  }

  Future<void> getProductSearch(BuildContext context, String query) async {
    emit(MaincubiteLoading());

    try {
      if (categoryData == null) {
        final category = await repo.getCategory();
        categoryData = category;
      }

      emit(MainCubiteProductAndSection(categoryData, null));
      final products = await repo.getProduct(query);
      emit(MainCubiteProductAndSection(categoryData, products));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(MaincubiteNetworkError());
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(MaincubiteError(_.toString()));
    }
  }

  Future<void> getvendorProducts(BuildContext context, int id) async {
    emit(MaincubiteLoading());

    try {
      final category = await repo.getProductByVendor(id);
      emit(VendorProductsLoaded(category));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(MaincubiteNetworkError());
    } catch (_) {
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(MaincubiteError(_.toString()));
    }
  }
}
