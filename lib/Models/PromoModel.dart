// To parse this JSON data, do
//
//     final promoModel = promoModelFromJson(jsonString);

import 'dart:convert';

PromoModel promoModelFromJson(String str) =>
    PromoModel.fromJson(json.decode(str));

String promoModelToJson(PromoModel data) => json.encode(data.toJson());

class PromoModel {
  PromoModel({
    this.data,
  });

  List<Datum> data;

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.timeBound,
    this.vendors,
    this.status,
    this.id,
    this.promoType,
    this.name,
    this.description,
    this.isPercent,
    this.value,
    this.minAmount,
    this.maxAmount,
    this.branch,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  bool timeBound;
  List<String> vendors;
  bool status;
  String id;
  String promoType;
  String name;
  String description;
  bool isPercent;
  int value;
  int minAmount;
  int maxAmount;
  String branch;
  String createdAt;
  String updatedAt;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        timeBound: json["timeBound"] == null ? null : json["timeBound"],
        vendors: json["vendors"] == null
            ? null
            : List<String>.from(json["vendors"].map((x) => x)),
        status: json["status"] == null ? null : json["status"],
        id: json["_id"] == null ? null : json["_id"],
        promoType: json["promoType"] == null ? null : json["promoType"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        isPercent: json["isPercent"] == null ? null : json["isPercent"],
        value: json["value"] == null ? null : json["value"],
        minAmount: json["minAmount"] == null ? null : json["minAmount"],
        maxAmount: json["maxAmount"] == null ? null : json["maxAmount"],
        branch: json["branch"] == null ? null : json["branch"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "timeBound": timeBound == null ? null : timeBound,
        "vendors":
            vendors == null ? null : List<dynamic>.from(vendors.map((x) => x)),
        "status": status == null ? null : status,
        "_id": id == null ? null : id,
        "promoType": promoType == null ? null : promoType,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "isPercent": isPercent == null ? null : isPercent,
        "value": value == null ? null : value,
        "minAmount": minAmount == null ? null : minAmount,
        "maxAmount": maxAmount == null ? null : maxAmount,
        "branch": branch == null ? null : branch,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
      };
}
