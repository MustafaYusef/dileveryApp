import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:tamataSrt/model/productsModel.dart';
import 'package:tamataSrt/ui/itemDetails.dart';

class itemCard1 extends StatelessWidget {
  Datum data;
  // String role;
  itemCard1(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ItemDetailsScreen(data);
          }));
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            margin: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Container(
                    //     child: Container(
                    //   margin: EdgeInsets.all(5),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       color: Colors.white),
                    //   width: 35,
                    //   height: 35,
                    //   child: Center(
                    //       child: !false
                    //           ? Icon(
                    //               Icons.favorite_border,
                    //             )
                    //           : Icon(
                    //               Icons.favorite,
                    //               color: Colors.red[600],
                    //             )),
                    // ))
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                data.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 140,
                          height: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              elevation: 5,
                              child: Center(
                                  child: Text(
                                data.price,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  "IQ " + data.price,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                    imageUrl: data.images[0],
                    placeholder: (context, url) => Image.asset(
                      "assets/images/placeholder.jpg",
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/placeholder.jpg",
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
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
