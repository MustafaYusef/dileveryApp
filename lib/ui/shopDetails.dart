import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamataSrt/bloc/mainBloc/cubit/maincubite_cubit.dart';
import 'package:tamataSrt/main.dart';
import 'package:tamataSrt/model/vendorModel.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';

import 'customUi/itemCard.dart';

class ShopDetails extends StatefulWidget {
  Vendor vendor;
  ShopDetails(this.vendor, {Key key}) : super(key: key);

  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (BuildContext context) {
          return MaincubiteCubit(MainRepostary())
            ..getvendorProducts(context, widget.vendor.id);
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: widget.vendor.image,
                          placeholder: (context, url) => Image.asset(
                            "assets/images/placeholder.jpg",
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/placeholder.jpg",
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 200,
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
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              widget.vendor.name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.call,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              widget.vendor.province +
                                                  " / " +
                                                  widget.vendor.address,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15)),
                                  ),
                                  width: 140,
                                  height: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15)),
                                    child: RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      elevation: 5,
                                      child: Center(
                                          child: Text(
                                        "المطعم التركي",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          bottom: 0,
                          right: 0,
                        ),
                        Positioned(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 27,
                            ),
                          ),
                          top: 50,
                          left: 20,
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<MaincubiteCubit, MaincubiteState>(
                    builder: (context, state) {
                      if (state is VendorProductsLoaded) {
                        return ListView.builder(
                            itemCount: state.products.products.data.length,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return itemCard1(
                                  state.products.products.data[index]);
                            });
                      }
                      if (state is MaincubiteLoading) {
                        return Container(
                          height: 400,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
