// To parse this JSON data, do
//
//     final popularInnerModel = popularInnerModelFromJson(jsonString);

import 'dart:convert';

PopularModel popularInnerModelFromJson(String str) =>
    PopularModel.fromJson(json.decode(str));

String popularInnerModelToJson(PopularModel data) => json.encode(data.toJson());

class PopularModel {
  PopularModel({
    this.count,
    this.data,
  });

  int count;
  List<Datum> data;

  factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
        count: json["count"] == null ? null : json["count"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.image,
    this.id,
    this.name,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.banner,
    this.description,
  });

  Banner image;
  String id;
  String name;
  String type;
  String createdAt;
  String updatedAt;
  int v;
  Banner banner;
  String description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        image: json["image"] == null ? null : Banner.fromJson(json["image"]),
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        banner: json["banner"] == null ? null : Banner.fromJson(json["banner"]),
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image.toJson(),
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
        "banner": banner == null ? null : banner.toJson(),
        "description": description == null ? null : description,
      };
}

class Banner {
  Banner({
    this.key,
    this.image,
  });

  String key;
  String image;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        key: json["key"] == null ? null : json["key"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "image": image == null ? null : image,
      };
}
