import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tamataSrt/bloc/orderBloc/cubit/ordercubit_cubit.dart';
import 'package:tamataSrt/model/productsModel.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:tamataSrt/ui/MainScreen.dart';
import 'package:tamataSrt/ui/customUi/itemCard.dart';
import 'package:tamataSrt/ui/customUi/itemCart.dart';

class OrderDetails extends StatefulWidget {
  int id;
  bool flage;

  OrderDetails(this.id, this.flage, {Key key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

List<String> status = ["ألغاء الطلب", "توصيل الطلب"];
String selectedStatuse;

class _OrderDetailsState extends State<OrderDetails> {
  TextEditingController noteController = TextEditingController();
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
              "تفاصيل الطلب",
              style: TextStyle(fontSize: 22),
            )),
      ),
      body: BlocProvider(
        create: (context) => OrdercubitCubit(MainRepostary())
          ..getOrderDetails(context, widget.id),
        child: Container(
          child: Column(
            children: [
              BlocBuilder<OrdercubitCubit, OrdercubitState>(
                builder: (context, state) {
                  if (state is OrdercubitDetailsLoaded) {
                    return Container(
                      height: MediaQuery.of(context).size.height - 190,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.order.order.products.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return itemCard1(
                                    Datum(
                                      id: state.order.order.products[index].id,
                                      name: state
                                          .order.order.products[index].name,
                                      description: state.order.order
                                          .products[index].description,
                                      images: state
                                          .order.order.products[index].images,
                                      vendor: state
                                          .order.order.products[index].vendor,
                                      category: state
                                          .order.order.products[index].category,
                                      price: state
                                          .order.order.products[index].price,
                                      published: state.order.order
                                          .products[index].published,
                                      createdAt: state.order.order
                                          .products[index].createdAt,
                                    ),
                                  );
                                }),
                          ),
                          state.order.order.status != "new" && !widget.flage
                              ? Container()
                              : Container(
                                  height: 50,
                                  margin: EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {
                                      ShowFeedback(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Center(
                                            child: Text(
                                          widget.flage
                                              ? "تعديل الطلب"
                                              : "ألغاء الطلب",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  }
                  if (state is OrdercubitLoading) {
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

  ShowFeedback(contex2) {
    // TextEditingController text = TextEditingController();

    // print("time ....  " + dateTimeNow.toString());
    var alertStyle = AlertStyle(
      // animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      // descTextAlign: TextAlign.start,
      alertPadding: EdgeInsets.all(10),
      buttonAreaPadding: EdgeInsets.all(10),
      animationDuration: Duration(milliseconds: 200),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
      alertAlignment: Alignment.center,
    );

    Alert(
        style: alertStyle,
        context: context,
        closeIcon: Icon(
          Icons.close,
          size: 25,
          color: Colors.black,
        ),
        closeFunction: () {
          Navigator.of(context).pop();
        },
        title: "تعديل الحالة",
        content: Container(
          width: MediaQuery.of(context).size.width - 100,
          height: 200,
          child: Column(
            children: [
              widget.flage ? dailogBodyPharmacy() : Container(),
              Container(
                margin: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Colors.grey,
                    primaryColorDark: Colors.grey,
                  ),
                  child: TextField(
                    maxLines: 2,
                    controller: noteController,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 18),
                    decoration: new InputDecoration(
                        alignLabelWithHint: false,
                        filled: true,
                        hasFloatingPlaceholder: false,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        labelText: 'ملاحظات',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          backgroundColor: Colors.white,
                        ),
                        prefixIcon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.all(7),
                        fillColor: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              radius: BorderRadius.circular(20),
              onPressed: () => null,
              child: InkWell(
                onTap: () {
                  BlocProvider.of<OrdercubitCubit>(contex2).updateOrder(
                      context,
                      status.indexOf(selectedStatuse) == 0
                          ? "cancel"
                          : "finish",
                      noteController.text.toString(),
                      widget.id);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 100,
                  child: Center(
                    child: Text(
                      "أرسال",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ))
        ]).show();
  }
}

class dailogBodyPharmacy extends StatefulWidget {
  const dailogBodyPharmacy({
    Key key,
  }) : super(key: key);

  @override
  _dailogBodyPharmacyState createState() => _dailogBodyPharmacyState();
}

class _dailogBodyPharmacyState extends State<dailogBodyPharmacy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButton(
          underline: Container(),
          dropdownColor: Colors.white,
          hint: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text("الحالة")),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 24,
          ),
          value: selectedStatuse,
          items: status.map((e) {
            return DropdownMenuItem(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      e,
                      style: TextStyle(fontSize: 18),
                    )),
                  ],
                ),
              ),
              value: e,
            );
          }).toList(),
          onChanged: (value) {
            print(value);
            setState(() {
              selectedStatuse = value;
              print(selectedStatuse);
            });
          }),
    );
  }
}
