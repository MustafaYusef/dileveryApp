// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SliderResModel SliderResModelFromJson(String str) =>
    SliderResModel.fromJson(json.decode(str));

class SliderResModel {
  SliderResModel({
    this.slider,
  });

  List<Slider> slider;

  factory SliderResModel.fromJson(Map<String, dynamic> json) => SliderResModel(
        slider:
            List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slider": List<dynamic>.from(slider.map((x) => x.toJson())),
      };
}

class Slider {
  Slider({
    this.id,
    this.image,
  });

  int id;
  String image;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
