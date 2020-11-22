import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamataSrt/bloc/mainBloc/cubit/maincubite_cubit.dart';
import 'package:tamataSrt/model/vendorModel.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:tamataSrt/ui/shopDetails.dart';

class ShopsScreen extends StatefulWidget {
  ShopsScreen({Key key}) : super(key: key);

  @override
  _ShopsScreenState createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MaincubiteCubit(MainRepostary())..getVendors(context, "");
      },
      child: Expanded(
        child: BlocBuilder<MaincubiteCubit, MaincubiteState>(
          builder: (BuildContext context, state) {
            if (state is MaincubiteLoading) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
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
                                    controller: searchController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (text) {
                                      print("submit $text");
                                      // getsearch(text);
                                    },
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
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is MaincubiteError) {
              return Container(
                child: Center(
                  child: Text(state.message),
                ),
              );
            }
            if (state is MaincubiteNetworkError) {
              return Container(
                child: Center(
                  child: Text("no net"),
                ),
              );
            }
            if (state is MaincubitVendorScreenLoaded)
              return Column(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
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
                                  controller: searchController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (text) {
                                    print("submit $text");
                                    // getsearch(text);

                                    BlocProvider.of<MaincubiteCubit>(context)
                                        .getVendors(context, text);
                                  },
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
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: state.vendors.vendors.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return itemCard(state.vendors.vendors[index]);
                          }),
                    ),
                  ),
                ],
              );
          },
          // child: Container(
          //   child: Column(
          //     children: [

          //       Expanded(
          //         child: BlocBuilder<MaincubiteCubit, MaincubiteState>(
          //           builder: (BuildContext context, state) {
          //             if (state is MaincubiteLoading) {
          //               return Container(
          //                 child: Center(
          //                   child: CircularProgressIndicator(),
          //                 ),
          //               );
          //             }
          //             if (state is MaincubiteError) {
          //               return Container(
          //                 child: Center(
          //                   child: Text(state.message),
          //                 ),
          //               );
          //             }
          //             if (state is MaincubiteNetworkError) {
          //               return Container(
          //                 child: Center(
          //                   child: Text("no net"),
          //                 ),
          //               );
          //             }
          //             if (state is MaincubitVendorScreenLoaded)
          //               return ListView.builder(
          //                   itemCount: state.vendors.vendors.length,
          //                   scrollDirection: Axis.vertical,
          //                   itemBuilder: (context, index) {
          //                     return itemCard(state.vendors.vendors[index]);
          //                   });
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}

class itemCard extends StatelessWidget {
  Vendor data;
  itemCard([this.data]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ShopDetails(data);
            }));
          },
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: data.image,
                  placeholder: (context, url) => Image.asset(
                    "assets/images/placeholder.jpg",
                    width: MediaQuery.of(context).size.width,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/placeholder.jpg",
                    width: MediaQuery.of(context).size.width,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.5,
                            1
                          ],
                          colors: [
                            Colors.black26.withOpacity(0.3),
                            Colors.transparent
                          ])),
                ),
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(15)),
                    ),
                    width: 140,
                    height: 40,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(15)),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        elevation: 5,
                        child: Center(
                            child: Text(
                          data.name,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  bottom: 0,
                  right: 0,
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          ),
        ),
      ],
    );
  }
}
