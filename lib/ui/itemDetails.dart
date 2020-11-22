import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamataSrt/bloc/cartBloc/cubit/cartcubite_cubit.dart';
import 'package:tamataSrt/database/database.dart';
import 'package:tamataSrt/model/productsModel.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:tamataSrt/ui/cartScreen.dart';

class ItemDetailsScreen extends StatefulWidget {
  int _current = 0;
  final Datum data;
  ItemDetailsScreen(this.data, {Key key}) : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final imageList = [
    "https://assets.simpleview-europe.com/leicestershire/imageresizer/?image=%2Fdmsimgs%2FRESIZED_HIGHX_SC_Mercedes_Highcross_N64_medium_310476805.jpg&action=FeaturedItems2x1",
    "https://www.aucklandcitymission.org.nz/wp-content/uploads/2015/11/kRdShop500x314.jpg",
    "https://www.miamiherald.com/latest-news/qvhisn/picture232448487/alternates/FREE_1140/20%20Bal%20Harbour%20Shops%20RF.jpg"
  ];
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text("التفاصيل",
                style: TextStyle(color: Colors.black, fontSize: 22))),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: 10),
            child: Badge(
              position: BadgePosition.topEnd(),
              badgeContent: Text(
                "",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              badgeColor: Colors.deepOrange,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return CartScreen();
                  }));
                },
                child: Icon(Icons.shopping_cart,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          )
        ],
      ),
      body: BlocProvider<CartcubiteCubit>(
        create: (BuildContext context) {
          return CartcubiteCubit(MainRepostary());
        },
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                itemDetailsslider(widget.data, widget._current),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "IQ" + widget.data.price,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              widget.data.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  widget.data.description,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (count > 1) {
                                        count--;
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Center(
                                          child: Text(
                                        "-",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      )),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    count.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      count++;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Center(
                                          child: Text(
                                        "+",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      )),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                                BlocBuilder<CartcubiteCubit, CartcubiteState>(
                                  builder: (context, state) {
                                    if (state is CartcubiteInitial) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width: 120,
                                        height: 45,
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<CartcubiteCubit>(
                                                    context)
                                                .addCart(
                                                    context,
                                                    ItemLocal(
                                                        widget.data.id,
                                                        widget.data.name,
                                                        count,
                                                        widget.data.images[0],
                                                        widget.data.price));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                    Icons
                                                        .add_shopping_cart_rounded,
                                                    color: Colors.white),
                                                Text(
                                                  "أضافة",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                ),
                                              ],
                                            )),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class itemDetailsslider extends StatefulWidget {
  final Datum data;
  int current;
  itemDetailsslider(
    this.data,
    this.current, {
    Key key,
  }) : super(key: key);

  @override
  _itemDetailssliderState createState() => _itemDetailssliderState();
}

class _itemDetailssliderState extends State<itemDetailsslider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: CarouselSlider.builder(
            itemCount: widget.data.images.length,
            height: MediaQuery.of(context).size.height / 2 - 50,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            autoPlay: false,
            aspectRatio: 2.0,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: Duration(seconds: 2),
            enlargeCenterPage: true,
            onPageChanged: (int index) {
              setState(() {
                widget.current = index;
              });
            },
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int itemIndex) => ClipRRect(
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height:
                                (MediaQuery.of(context).size.height / 2) + 40,
                            imageUrl: widget.data.images[widget.current],
                            placeholder: (context, url) => Image.asset(
                                "assets/images/fashion.jpg",
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height / 2 - 50,
                                width: MediaQuery.of(context).size.width),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/fashion.jpg",
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.height / 2 - 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius:
                      //       BorderRadius.circular(0.0),
                      // ),
                      elevation: 0,
                    ),
                  )),
            ),
          ),
        ),
        Positioned(
            bottom: 0.0,
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.data.images.map((image) {
                  return Container(
                    width: 30.0,
                    height: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color:
                            widget.current == widget.data.images.indexOf(image)
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
                  );
                }).toList(),
              ),
            )),
        // Positioned(
        //     bottom: 20.0,
        //     right: 10.0,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         Container(
        //           margin: EdgeInsets.only(bottom: 10),
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.all(Radius.circular(22.5)),
        //               color: Colors.white),
        //           width: 45,
        //           height: 45,
        //           child: Center(
        //               child: !true
        //                   ? Icon(
        //                       Icons.favorite_border,
        //                       size: 25,
        //                     )
        //                   : Icon(
        //                       Icons.favorite,
        //                       size: 25,
        //                       color: Colors.red[600],
        //                     )),
        //         ),
        //       ],
        //     ))
      ]),
    );
  }
}
