import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamataSrt/bloc/orderBloc/cubit/ordercubit_cubit.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:tamataSrt/ui/orderDetails.dart';
import 'package:tamataSrt/ui/profileScreen.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    getToken();

    super.initState();
  }

  bool flage = false;
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final role = await prefs.get('role');
    flage = role != "customer";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        centerTitle: true,
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "الطلبات",
              style: TextStyle(fontSize: 22),
            )),
        actions: [
          flage
              ? Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ProfileScreen();
                      }));
                    },
                    child: Icon(
                      Icons.person,
                      size: 27,
                    ),
                  ))
              : Container()
        ],
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return OrdercubitCubit(MainRepostary())..GetOrders(context);
        },
        child: BlocBuilder<OrdercubitCubit, OrdercubitState>(
          builder: (context, state) {
            if (state is OrdercubitLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: state.oredrs.orders.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return OrderDetails(
                                      state.oredrs.orders.data[index].id,
                                      flage);
                                }));
                              },
                              child: Card(
                                margin: EdgeInsets.all(5),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            state.oredrs.orders.data[index]
                                                .createdAt,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.oredrs.orders.data[index]
                                                .status,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "IQ " +
                                                state.oredrs.orders.data[index]
                                                    .totalPrice,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              );
            }
            if (state is OrdercubitLoading) {
              return Column(
                children: [
                  Expanded(
                      child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
