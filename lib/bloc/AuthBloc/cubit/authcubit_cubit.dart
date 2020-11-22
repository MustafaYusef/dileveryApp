import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamataSrt/model/profileModel.dart';
import 'package:tamataSrt/model/provinesModel.dart';
import 'package:tamataSrt/repastory/authRepastory.dart';
import 'package:tamataSrt/ui/authUi/loginScreen.dart';
import 'package:tamataSrt/ui/authUi/sendCodeScreen.dart';
import 'package:tamataSrt/ui/odersScreen.dart';
import 'package:toast/toast.dart';

import '../../../main.dart';

part 'authcubit_state.dart';

class AuthcubitCubit extends Cubit<AuthcubitState> {
  final AuthRepostary repo;
  AuthcubitCubit(this.repo) : super(AuthcubitInitial());

  Future<void> LoginRequest(
      BuildContext context, String phone, String pass) async {
    emit(AuthcubitLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // final token = await prefs.get('token');
      // final verify = repo.checkPhone(token);
      final login = await repo.login(phone, pass);
      await prefs.setString('token', "Bearer " + login.token);
      await prefs.setString('role', login.role);
      Toast.show("تم الدخول بنجاح", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      if (login.verified) {
        if (login.role != "customer") {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return OrdersScreen();
          }));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return Main(0);
          }));
        }
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return PinCodeVerificationScreen(phone);
        }));
      }
      // emit(AuthcubitLogin(login));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(AuthcubitInitial());
    } catch (_) {
      print(_.toString());
      Toast.show(_.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(AuthcubitInitial());
    }
  }

  Future<void> RegesterRequest(BuildContext context, String name, String phone,
      String password, int provId, String address) async {
    emit(AuthcubitLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final resources =
          await repo.regester(name, phone, password, provId, address);
      // final verify = repo.checkPhone(resources.token);
      await prefs.setString('token', "Bearer " + resources.token);

      Toast.show("تم انشاء حساب بنجاح", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return LoginScreen();
      }));
      // emit(AuthcubitLogin(login));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(AuthcubitLoginNetworkError());
    } catch (_) {
      if (_ == "unValid") {
        Toast.show("not authrized", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show(_.toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }

      // emit(AuthcubitLoginError(_.toString()));
    }
  }

  Future<void> Profile(BuildContext context) async {
    emit(AuthcubitLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // final verify = repo.checkPhone(resources.token);
      final token = await prefs.getString('token');
      if (token == null || token.isEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return LoginScreen();
        }));
      } else {
        final resources = await repo.getProfile(token);

        emit(ProfileLoaded(resources));
      }
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(AuthcubitLoginNetworkError());
    } catch (_) {
      if (_.toString().split(" ")[1] == "400") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return PinCodeVerificationScreen();
        }));
        Toast.show("not verify", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else if (_.toString().split(" ")[1] == "401") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return LoginScreen();
        }));
        Toast.show("not verify", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show(_.toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }

      // emit(AuthcubitLoginError(_.toString()));
    }
  }

  Future<void> getProvines(BuildContext context) async {
    emit(AuthcubitLoading());

    try {
      final resources = await repo.getProvines();

      emit(ProvinesLoaded(resources));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      emit(AuthcubitLoginNetworkError());
    } catch (_) {
      if (_ == "unValid") {
        Toast.show("not authrized", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show(_.toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }

      emit(AuthcubitLoginError(_.toString()));
    }
  }

  Future<void> sendCodeSms(BuildContext context) async {
    emit(AuthcubitLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // final verify = repo.checkPhone(resources.token);
      final token = await prefs.getString('token');
      print("token    :   " + token);
      final resources = await repo.sendCodeSms(token);
      Toast.show(resources.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(AuthcubitProfileLoaded(resources));
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      //   return LoginScreen();
      // }));
      emit(AuthcubitInitial());
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(AuthcubitLoginNetworkError());
      emit(AuthcubitInitial());
    } catch (_) {
      if (_ == "unValid") {
        Toast.show("not authrized", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show(_.toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
      emit(AuthcubitInitial());

      // emit(AuthcubitLoginError(_.toString()));
    }
  }

  Future<void> verifyCode(BuildContext context, String code) async {
    emit(AuthcubitLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // final verify = repo.checkPhone(resources.token);
      final token = await prefs.getString('token');
      final role = await prefs.getString('role');
      final resources = await repo.verifyCode(token, code);
      Toast.show(resources.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      //emit(AuthcubitLoading());
      if (role == "customer") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return Main(0);
        }));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return OrdersScreen();
        }));
      }

      // emit(AuthcubitProfileLoaded(resources));
    } on SocketException catch (_) {
      Toast.show("There is no internet connection", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // emit(AuthcubitLoginNetworkError());
      emit(AuthcubitInitial());
    } catch (_) {
      if (_ == "unValid") {
        Toast.show("not authrized", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        emit(AuthcubitInitial());
      } else {
        Toast.show(_.toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        emit(AuthcubitInitial());
      }

      // emit(AuthcubitLoginError(_.toString()));
    }
  }
}
