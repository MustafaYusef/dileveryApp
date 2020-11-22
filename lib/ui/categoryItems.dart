import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamataSrt/bloc/mainBloc/cubit/maincubite_cubit.dart';
import 'package:tamataSrt/model/ordersModel.dart';
import 'package:tamataSrt/model/productsModel.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:tamataSrt/ui/MainScreen.dart';

import 'customUi/itemCard.dart';

class CategoryItems extends StatefulWidget {
  int id;
  CategoryItems(this.id);

  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
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
              "الأقسام",
              style: TextStyle(fontSize: 22),
            )),
      ),
      body: BlocProvider(
        create: (context) => MaincubiteCubit(MainRepostary())
          ..getProductScreen(context, widget.id),
        child: Container(
          child: BlocBuilder<MaincubiteCubit, MaincubiteState>(
            builder: (context, state) {
              if (state is MainCubiteProductAndSection) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: state.category.categories.length,
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.bounceIn,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 120,
                              height: 35,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: RaisedButton(
                                  color: index == widget.id - 1
                                      ? Theme.of(context).primaryColor
                                      : Color(0xffF0F0F0),
                                  elevation: 5,
                                  child: Center(
                                      child: Text(
                                    state.category.categories[index].name,
                                    style: TextStyle(
                                        color: index == widget.id - 1
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  )),
                                  onPressed: () {
                                    setState(() {
                                      widget.id = index + 1;
                                    });
                                    context
                                        .bloc<MaincubiteCubit>()
                                        .getProductScreen(
                                            context,
                                            state
                                                .category.categories[index].id);
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Directionality(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              child: Theme(
                                data: new ThemeData(
                                  primaryColor: Colors.white,
                                  primaryColorDark: Colors.black,
                                ),
                                child: TextField(
                                  onSubmitted: (text) {
                                    if (text.isNotEmpty) {
                                      context
                                          .bloc<MaincubiteCubit>()
                                          .getProductSearch(context, text);
                                    } else {
                                      context
                                          .bloc<MaincubiteCubit>()
                                          .getProductScreen(context, widget.id);
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 20),
                                  decoration: new InputDecoration(
                                      alignLabelWithHint: false,
                                      filled: false,
                                      hasFloatingPlaceholder: false,
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      hintStyle: new TextStyle(
                                          color: Colors.grey[800]),
                                      labelText: "بحث",
                                      labelStyle: TextStyle(
                                          fontSize: 18,
                                          backgroundColor: Colors.white,
                                          decorationColor: Colors.white),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 6,
                                          right: 6,
                                          top: 0,
                                          bottom: 15),
                                      fillColor: Colors.white70),
                                ),
                              ),
                            ),
                            textDirection: TextDirection.rtl),
                      ),
                    ),
                    state.products == null
                        ? Container()
                        : Expanded(
                            child: ListView.builder(
                                itemCount: state.products.products.data.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return itemCard1(
                                      state.products.products.data[index]);
                                }),
                          ),
                  ],
                );
              }
              if (state is MaincubiteLoading) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
