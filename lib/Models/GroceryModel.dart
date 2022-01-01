// To parse this JSON data, do
//
//     final groceryModel = groceryModelFromJson(jsonString);

import 'dart:convert';

GroceryModel groceryModelFromJson(String str) =>
    GroceryModel.fromJson(json.decode(str));

String groceryModelToJson(GroceryModel data) => json.encode(data.toJson());

class GroceryModel {
  GroceryModel({
    this.branch,
    this.stores,
  });

  Branch branch;
  List<Store> stores;

  factory GroceryModel.fromJson(Map<String, dynamic> json) => GroceryModel(
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        stores: json["stores"] == null
            ? null
            : List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branch": branch == null ? null : branch.toJson(),
        "stores": stores == null
            ? null
            : List<dynamic>.from(stores.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    this.id,
    this.location,
    this.status,
    this.radius,
    this.name,
    this.supportNumber,
    this.offers,
    this.branchBanner,
    this.distance,
  });

  String id;
  BranchLocation location;
  bool status;
  dynamic radius;
  String name;
  dynamic supportNumber;
  List<dynamic> offers;
  List<BranchBanner> branchBanner;
  double distance;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null
            ? null
            : BranchLocation.fromJson(json["location"]),
        status: json["status"] == null ? null : json["status"],
        radius: json["radius"] == null ? null : json["radius"],
        name: json["name"] == null ? null : json["name"],
        supportNumber:
            json["supportNumber"] == null ? null : json["supportNumber"],
        offers: json["offers"] == null
            ? null
            : List<dynamic>.from(json["offers"].map((x) => x)),
        branchBanner: json["branchBanner"] == null
            ? null
            : List<BranchBanner>.from(
                json["branchBanner"].map((x) => BranchBanner.fromJson(x))),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location.toJson(),
        "status": status == null ? null : status,
        "radius": radius == null ? null : radius,
        "name": name == null ? null : name,
        "supportNumber": supportNumber == null ? null : supportNumber,
        "offers":
            offers == null ? null : List<dynamic>.from(offers.map((x) => x)),
        "branchBanner": branchBanner == null
            ? null
            : List<dynamic>.from(branchBanner.map((x) => x.toJson())),
        "distance": distance == null ? null : distance,
      };
}

class BranchBanner {
  BranchBanner({
    this.clickable,
    this.id,
    this.linkId,
    this.image,
  });

  bool clickable;
  String id;
  String linkId;
  StoreBg image;

  factory BranchBanner.fromJson(Map<String, dynamic> json) => BranchBanner(
        clickable: json["clickable"] == null ? null : json["clickable"],
        id: json["_id"] == null ? null : json["_id"],
        linkId: json["linkId"] == null ? null : json["linkId"],
        image: json["image"] == null ? null : StoreBg.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "clickable": clickable == null ? null : clickable,
        "_id": id == null ? null : id,
        "linkId": linkId == null ? null : linkId,
        "image": image == null ? null : image.toJson(),
      };
}

class StoreBg {
  StoreBg({
    this.key,
    this.image,
  });

  String key;
  String image;

  factory StoreBg.fromJson(Map<String, dynamic> json) => StoreBg(
        key: json["key"] == null ? null : json["key"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "image": image == null ? null : image,
      };
}

class BranchLocation {
  BranchLocation({
    this.type,
    this.coordinates,
    this.address,
  });

  String type;
  List<double> coordinates;
  String address;

  factory BranchLocation.fromJson(Map<String, dynamic> json) => BranchLocation(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        address: json["address"] == null ? null : json["address"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
        "address": address == null ? null : address,
      };
}

class Store {
  Store({
    this.id,
    this.location,
    this.quickDelivery,
    this.storeStatus,
    this.featured,
    this.name,
    this.branch,
    this.type,
    this.openTime,
    this.closeTime,
    this.sortOrder,
    this.storeLogo,
    this.storeBg,
    this.rating,
    this.distance,
    this.minimumOrderValue,
  });

  String id;
  StoreLocation location;
  bool quickDelivery;
  bool storeStatus;
  bool featured;
  String name;
  String branch;
  String type;
  String openTime;
  String closeTime;
  dynamic sortOrder;
  StoreBg storeLogo;
  StoreBg storeBg;
  double rating;
  double distance;
  int minimumOrderValue;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null
            ? null
            : StoreLocation.fromJson(json["location"]),
        quickDelivery:
            json["quickDelivery"] == null ? null : json["quickDelivery"],
        storeStatus: json["storeStatus"] == null ? null : json["storeStatus"],
        featured: json["featured"] == null ? null : json["featured"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : json["branch"],
        type: json["type"] == null ? null : json["type"],
        openTime: json["openTime"] == null ? null : json["openTime"],
        closeTime: json["closeTime"] == null ? null : json["closeTime"],
        sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
    minimumOrderValue: json["minimumOrderValue"] == null ? null : json["minimumOrderValue"],

    storeLogo: json["storeLogo"] == null
            ? null
            : StoreBg.fromJson(json["storeLogo"]),
        storeBg:
            json["storeBg"] == null ? null : StoreBg.fromJson(json["storeBg"]),
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location.toJson(),
        "quickDelivery": quickDelivery == null ? null : quickDelivery,
        "storeStatus": storeStatus == null ? null : storeStatus,
        "featured": featured == null ? null : featured,
        "name": name == null ? null : name,
        "branch": branch == null ? null : branch,
        "type": type == null ? null : type,
        "openTime": openTime == null ? null : openTime,
        "closeTime": closeTime == null ? null : closeTime,
        "sortOrder": sortOrder == null ? null : sortOrder,
        "storeLogo": storeLogo == null ? null : storeLogo.toJson(),
        "storeBg": storeBg == null ? null : storeBg.toJson(),
        "rating": rating == null ? null : rating,
        "distance": distance == null ? null : distance,
    "minimumOrderValue": minimumOrderValue == null ? null : minimumOrderValue,

  };
}

class StoreLocation {
  StoreLocation({
    this.address,
  });

  String address;

  factory StoreLocation.fromJson(Map<String, dynamic> json) => StoreLocation(
        address: json["address"] == null ? null : json["address"],
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
      };
}
