import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tamataSrt/model/sliderModel.dart';

class sliderSection extends StatefulWidget {
  sliderSection({
    Key key,
    @required this.data,
    @required int current,
  })  : _current = current,
        super(key: key);

  final SliderResModel data;
  int _current;

  @override
  _sliderSectionState createState() => _sliderSectionState();
}

class _sliderSectionState extends State<sliderSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider.builder(
            itemCount:
                widget.data.slider.length == 0 ? 1 : widget.data.slider.length,
            height: (MediaQuery.of(context).size.height / 4) + 20,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            autoPlay: true,
            aspectRatio: 2.0,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: Duration(seconds: 2),
            enlargeCenterPage: true,
            onPageChanged: (int index) {
              setState(() {
                widget._current = index;
              });
            },
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int itemIndex) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      margin: EdgeInsets.all(10),
                      semanticContainer: true,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height:
                                (MediaQuery.of(context).size.height / 2) + 40,
                            imageUrl: widget.data.slider.length == 0
                                ? "s"
                                : widget.data.slider[widget._current].image,
                            placeholder: (context, url) => Image.asset(
                                "assets/images/fashion.jpg",
                                fit: BoxFit.cover,
                                height:
                                    (MediaQuery.of(context).size.height / 2) +
                                        40,
                                width: MediaQuery.of(context).size.width),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/fashion.jpg",
                              width: MediaQuery.of(context).size.width,
                              height:
                                  (MediaQuery.of(context).size.height / 2) + 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      elevation: 0,
                    ),
                  )),
            ),
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.data.slider.map((image) {
                  return Container(
                    width: 30.0,
                    height: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        color:
                            widget._current == widget.data.slider.indexOf(image)
                                ? Theme.of(context).primaryColor
                                : Colors.grey[300]),
                  );
                }).toList(),
              ),
            )),
      ]),
    );
  }
}
