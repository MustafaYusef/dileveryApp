import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamataSrt/bloc/AuthBloc/cubit/authcubit_cubit.dart';
import 'package:tamataSrt/repastory/authRepastory.dart';
import 'package:toast/toast.dart';

import '../../main.dart';
import 'logInScreen.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  PinCodeVerificationScreen([this.phoneNumber]);
  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;
  bool flage = true;
  TextEditingController PassController = TextEditingController();

  bool isLoading = false;

  /// this [StreamController] will take input of which function should be called

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () async {
        try {} catch (e) {}
      };

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'التحقق من رقم الهاتف',
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      key: scaffoldKey,
      body: BlocProvider(
        create: (BuildContext context) {
          return AuthcubitCubit(AuthRepostary())..sendCodeSms(context);
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/placeholder.png',
                    height: MediaQuery.of(context).size.height / 4,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: RichText(
                        text: TextSpan(
                            text: "أدخل الرمز المرسل إلى ",
                            children: [
                              TextSpan(
                                  text: widget.phoneNumber,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                                fontSize: 16)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        length: 6,
                        obsecureText: false,
                        animationType: AnimationType.fade,
                        shape: PinCodeFieldShape.underline,
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        onChanged: (value) {
                          setState(() {
                            if (value.length != 6) {
                              hasError = true;
                            } else {
                              hasError = false;
                            }
                            currentText = value;
                          });
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    // error showing widget
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        hasError ? "*املأ الحقول بشكل صحيح" : "",
                        style:
                            TextStyle(color: Colors.red.shade300, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: BlocBuilder<AuthcubitCubit, AuthcubitState>(
                      builder: (context, state) {
                        if (state is AuthcubitInitial) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 30),
                            child: ButtonTheme(
                              height: 50,
                              child: FlatButton(
                                onPressed: () {
                                  //
                                  if (!hasError) {
                                    BlocProvider.of<AuthcubitCubit>(context)
                                        .verifyCode(context, currentText);
                                  } else {
                                    print("error ......");
                                  }
                                },
                                child: Center(
                                    child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    "تاكيد الرمز",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).primaryColor,
                                      offset: Offset(1, -2),
                                      blurRadius: 10),
                                  BoxShadow(
                                      color: Theme.of(context).primaryColor,
                                      offset: Offset(-1, 2),
                                      blurRadius: 10)
                                ]),
                          );
                        }
                        if (state is AuthcubitLoading) {
                          return Container(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "لم تصلك رسالة؟ ",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                          children: [
                            TextSpan(
                                text: "إعادة ارسال",
                                recognizer: onTapRecognizer,
                                style: TextStyle(
                                    color: Color(0xFF91D3B3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
