import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tamataSrt/bloc/cartBloc/cubit/cartcubite_cubit.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:tamataSrt/ui/customUi/itemCart.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
              "سلة المشتريات",
              style: TextStyle(fontSize: 22),
            )),
      ),
      body: BlocProvider(
        create: (context) => CartcubiteCubit(MainRepostary())..getCart(context),
        child: Container(
          child: Column(
            children: [
              BlocBuilder<CartcubiteCubit, CartcubiteState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return Container(
                      height: MediaQuery.of(context).size.height - 190,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.items.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                      actions: <Widget>[
                                        IconSlideAction(
                                          caption: 'حذف',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () async {
                                            BlocProvider.of<CartcubiteCubit>(
                                                    context)
                                                .deleteItem(context,
                                                    state.items[index].itemId);
                                          },
                                        ),
                                      ],
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          caption: 'حذف',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () async {
                                            BlocProvider.of<CartcubiteCubit>(
                                                    context)
                                                .deleteItem(context,
                                                    state.items[index].itemId);
                                          },
                                        ),
                                      ],
                                      actionExtentRatio: 0.35,
                                      actionPane: SlidableDrawerActionPane(),
                                      child: ItemCart(state.items[index]));
                                }),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.all(10),
                            child: state.orderLoading
                                ? CircularProgressIndicator()
                                : InkWell(
                                    onTap: () {
                                      final List<OrderObject> list = state.items
                                          .map((e) =>
                                              OrderObject(e.itemId, e.quantity))
                                          .toList();

                                      BlocProvider.of<CartcubiteCubit>(context)
                                          .makeOrder(context, "88288229222",
                                              "address", list);
                                    },
                                    child: state.items.isEmpty
                                        ? Container()
                                        : Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Center(
                                                  child: Text(
                                                "أرسال الطلب",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ),
                                  ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is CartcubiteInitial) {
                    return Expanded(
                        child: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
