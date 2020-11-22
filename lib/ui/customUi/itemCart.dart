import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tamataSrt/database/database.dart';

class ItemCart extends StatelessWidget {
  ItemLocal data;
  ItemCart([this.data]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      width: MediaQuery.of(context).size.width - 10,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          margin: EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[],
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
                        margin: EdgeInsets.only(right: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                "IQ " + data.price.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 30,
                              height: 30,
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
                              data.quantity.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 30,
                              height: 30,
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
                        ],
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
                  imageUrl: data.image,
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
    );
  }
}
