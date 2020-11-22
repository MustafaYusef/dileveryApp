import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tamataSrt/bloc/mainBloc/cubit/maincubite_cubit.dart';
import 'package:tamataSrt/model/categoryModel.dart';
import 'package:tamataSrt/model/vendorModel.dart';
import 'package:tamataSrt/repastory/mainRepostary.dart';
import 'package:tamataSrt/ui/categoryItems.dart';
import 'package:tamataSrt/ui/shopDetails.dart';
import 'customUi/itemCard.dart';
import 'customUi/sliderSection.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _current = 0;

  final iconList = [
    Icon(
      Icons.ac_unit,
      color: Colors.red,
      size: 35,
    ),
    Icon(
      Icons.ac_unit,
      color: Colors.red,
      size: 30,
    ),
    Icon(
      Icons.ac_unit,
      color: Colors.red,
      size: 30,
    ),
    Icon(
      Icons.ac_unit,
      color: Colors.red,
      size: 30,
    ),
    Icon(
      Icons.ac_unit,
      color: Colors.red,
      size: 30,
    ),
    Icon(
      Icons.ac_unit,
      color: Colors.red,
      size: 30,
    ),
  ];

  final imageList = [
    "https://assets.simpleview-europe.com/leicestershire/imageresizer/?image=%2Fdmsimgs%2FRESIZED_HIGHX_SC_Mercedes_Highcross_N64_medium_310476805.jpg&action=FeaturedItems2x1",
    "https://www.aucklandcitymission.org.nz/wp-content/uploads/2015/11/kRdShop500x314.jpg",
    "https://www.miamiherald.com/latest-news/qvhisn/picture232448487/alternates/FREE_1140/20%20Bal%20Harbour%20Shops%20RF.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MaincubiteCubit(MainRepostary())..getMain(context),
      child: Container(
        child: Container(
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
                          margin:
                              EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.white,
                              primaryColorDark: Colors.black,
                            ),
                            child: TextField(
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 20),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return CategoryItems(0);
                                }));
                              },
                              decoration: new InputDecoration(
                                  alignLabelWithHint: false,
                                  filled: false,
                                  hasFloatingPlaceholder: false,
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[600]),
                                  labelText: "بحث",
                                  hintText: "بحث",
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      backgroundColor: Colors.white,
                                      decorationColor: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 6, right: 6, top: 0, bottom: 15),
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ),
                        textDirection: TextDirection.rtl),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<MaincubiteCubit, MaincubiteState>(
                  builder: (context, state) {
                    if (state is MaincubiteError) {}
                    if (state is MaincubitLoaded) {
                      return SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              sliderSection(
                                  data: state.slider, current: _current),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                            "الأقسام",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: state.category == null
                                    ? Container()
                                    : ListView.builder(
                                        itemCount:
                                            state.category.categories.length,
                                        shrinkWrap: true,
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return sectionCard(
                                              state.category.categories[index]);
                                        }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          "عرض المزيد",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          "أبرز المحلات",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              ),
                              Container(
                                height: 200,
                                child: state.vendors == null
                                    ? Container()
                                    : ListView.builder(
                                        itemCount: state.vendors.vendors.length,
                                        shrinkWrap: true,
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return itemCard(
                                              state.vendors.vendors[index]);
                                        }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          "المضاف حديثا",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              ),
                              Container(
                                height: 200,
                                child: state.vendors == null
                                    ? Container()
                                    : ListView.builder(
                                        itemCount: state.vendors.vendors.length,
                                        shrinkWrap: true,
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return itemCard(
                                              state.vendors.vendors[index]);
                                        }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          "عرض المزيد",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          "الأكثر مبيعا",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              ),
                              Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                child: state.products == null
                                    ? Container()
                                    : ListView.builder(
                                        itemCount:
                                            state.products.products.data.length,
                                        shrinkWrap: true,
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return itemCard1(state
                                              .products.products.data[index]);
                                        }),
                              ),
                            ],
                          ),
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class itemCard extends StatelessWidget {
  Vendor vendor;
  itemCard([this.vendor]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ShopDetails(vendor);
            }));
          },
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 150,
                  width: MediaQuery.of(context).size.width - 130,
                  imageUrl: vendor.image,
                  placeholder: (context, url) => Image.asset(
                    "assets/images/placeholder.jpg",
                    width: MediaQuery.of(context).size.width - 130,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/placeholder.jpg",
                    width: MediaQuery.of(context).size.width - 130,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width - 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
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
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(7),
          ),
        ),
        Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              vendor.name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}

class sectionCard extends StatelessWidget {
  Category category;
  sectionCard([this.category]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (category != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CategoryItems(category.id);
          }));
        }
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              width: 120,
              imageUrl: category != null ? category.icon : "",
              placeholder: (context, url) => Image.asset(
                "assets/images/placeholder.jpg",
                width: 130,
                height: 120,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/placeholder.jpg",
                width: 130,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Directionality(
                      child: Text(
                        category != null ? category.name : "",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                        0.5,
                        1
                      ],
                      colors: [
                        Colors.black26.withOpacity(0.5),
                        Colors.transparent
                      ])),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(7),
      ),
    );
  }
}
// class sectionCard extends StatelessWidget {
//   Icon icon;
//   sectionCard(this.icon);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Card(
//         color: Colors.transparent,
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Container(
//           padding: EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(padding: EdgeInsets.all(10), child: icon),
//               Padding(
//                 padding: const EdgeInsets.all(0.0),
//                 child: Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: Text(
//                     "ملابس",
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
