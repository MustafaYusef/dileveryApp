import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamataSrt/ui/MainScreen.dart';
import 'package:tamataSrt/ui/cartScreen.dart';
import 'package:tamataSrt/ui/customUi/bottomNavigationBar.dart';
import 'package:tamataSrt/ui/notificationScreen.dart';
import 'package:tamataSrt/ui/odersScreen.dart';
import 'package:tamataSrt/ui/profileScreen.dart';
import 'package:tamataSrt/ui/shopsScreen.dart';

void main() {
  runApp(baseWedget());
}

class baseWedget extends StatefulWidget {
  const baseWedget({Key key}) : super(key: key);

  @override
  _baseWedgetState createState() => _baseWedgetState();
}

class _baseWedgetState extends State<baseWedget> {
  @override
  void initState() {
    getToken();

    super.initState();
  }

  bool flage = false;
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = await prefs.get('role');
    flage = token != "customer";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color(0xffEF5553)),
        debugShowCheckedModeBanner: false,
        home: flage ? OrdersScreen() : Main(0));
  }
}

class Main extends StatefulWidget {
  int selectedItem = 0;
  Main(this.selectedItem, {Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            elevation: 0,
          )),
      body: SafeArea(child: selectedWidget(widget.selectedItem)),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedIndex: widget.selectedItem,
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              inactiveColor: Colors.white,
              activeColor: Theme.of(context).primaryColor,
              title: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text("الرئيسية")))),
          BottomNavyBarItem(
              inactiveColor: Colors.white,
              icon: Icon(Icons.store),
              activeColor: Theme.of(context).primaryColor,
              title: Directionality(
                  textDirection: TextDirection.rtl, child: Text("المحلات"))),
          BottomNavyBarItem(
              inactiveColor: Colors.white,
              icon: Icon(Icons.shopping_cart),
              activeColor: Theme.of(context).primaryColor,
              title: Directionality(
                  textDirection: TextDirection.rtl, child: Text("المشتريات"))),
          BottomNavyBarItem(
              inactiveColor: Colors.white,
              icon: Icon(Icons.local_offer_rounded),
              activeColor: Theme.of(context).primaryColor,
              title: Directionality(
                  textDirection: TextDirection.rtl, child: Text("الطلبات"))),
          BottomNavyBarItem(
              inactiveColor: Colors.white,
              activeColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.account_circle),
              title: Directionality(
                  textDirection: TextDirection.rtl, child: Text("الحساب"))),
        ],
        onItemSelected: (int value) {
          setState(() {
            widget.selectedItem = value;
          });
        },
      ),
    );
  }

  Widget selectedWidget(int index) {
    if (index == 0) {
      return MainScreen();
    } else if (index == 1) {
      return ShopsScreen();
    } else if (index == 2) {
      return CartScreen();
    } else if (index == 3) {
      return OrdersScreen();
    } else if (index == 4) {
      return ProfileScreen();
    }
  }

  String getTitle(int index) {
    if (index == 0) {
      return "الرئيسية";
    } else if (index == 1) {
      return "المشتريات";
    } else if (index == 2) {
      return "الأشعارات";
    } else if (index == 3) {
      return "الطلبات";
    } else if (index == 4) {
      return "الحساب";
    }
  }
}
