// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

StoreModel storeModelFromJson(String str) =>
    StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  StoreModel({
    this.branch,
    this.quick,
    this.recommended,
    this.restaurant,
  });

  Branch branch;
  List<Quick> quick;
  List<Quick> recommended;
  List<Quick> restaurant;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        quick: json["quick"] == null
            ? null
            : List<Quick>.from(json["quick"].map((x) => Quick.fromJson(x))),
        recommended: json["recommended"] == null
            ? null
            : List<Quick>.from(
                json["recommended"].map((x) => Quick.fromJson(x))),
        restaurant: json["restaurant"] == null
            ? null
            : List<Quick>.from(
                json["restaurant"].map((x) => Quick.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branch": branch == null ? null : branch.toJson(),
        "quick": quick == null
            ? null
            : List<dynamic>.from(quick.map((x) => x.toJson())),
        "recommended": recommended == null
            ? null
            : List<dynamic>.from(recommended.map((x) => x.toJson())),
        "restaurant": restaurant == null
            ? null
            : List<dynamic>.from(restaurant.map((x) => x.toJson())),
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
    this.activeMessage,
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
  ActiveMessage activeMessage;
  dynamic distance;

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
        activeMessage: json["activeMessage"] == null
            ? null
            : ActiveMessage.fromJson(json["activeMessage"]),
        distance: json["distance"] == null ? null : json["distance"],
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
        "activeMessage": activeMessage == null ? null : activeMessage.toJson(),
        "distance": distance == null ? null : distance,
      };
}

class ActiveMessage {
  ActiveMessage({
    this.icon,
    this.id,
    this.title,
    this.description,
  });

  Picture icon;
  String id;
  String title;
  String description;

  factory ActiveMessage.fromJson(Map<String, dynamic> json) => ActiveMessage(
        icon: json["icon"] == null ? null : Picture.fromJson(json["icon"]),
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon == null ? null : icon.toJson(),
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
      };
}

class Picture {
  Picture({
    this.key,
    this.image,
  });

  String key;
  String image;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        key: json["key"] == null ? null : json["key"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "image": image == null ? null : image,
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

class Quick {
  Quick({
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
    this.cuisine,
    this.sortOrder,
    this.avgCookingTime,
    this.avgPersonAmt,
    this.storeLogo,
    this.storeBg,
    this.rating,
    this.distance,
    this.minimumOrderValue,
  });

  String id;
  QuickLocation location;
  bool quickDelivery;
  bool storeStatus;
  bool featured;
  String name;
  String branch;
  String type;
  String openTime;
  String closeTime;
  String cuisine;
  dynamic sortOrder;
  dynamic avgCookingTime;
  dynamic avgPersonAmt;
  StoreBg storeLogo;
  StoreBg storeBg;
  dynamic rating;
  double distance;
  int minimumOrderValue;

  factory Quick.fromJson(Map<String, dynamic> json) => Quick(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null
            ? null
            : QuickLocation.fromJson(json["location"]),
        quickDelivery:
            json["quickDelivery"] == null ? null : json["quickDelivery"],
        storeStatus: json["storeStatus"] == null ? null : json["storeStatus"],
        featured: json["featured"] == null ? null : json["featured"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : json["branch"],
        type: json["type"] == null ? null : json["type"],
        openTime: json["openTime"] == null ? null : json["openTime"],
        closeTime: json["closeTime"] == null ? null : json["closeTime"],
        cuisine: json["cuisine"] == null ? null : json["cuisine"],
        sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
        minimumOrderValue: json["minimumOrderValue"] == null
            ? null
            : json["minimumOrderValue"],
        avgCookingTime:
            json["avgCookingTime"] == null ? null : json["avgCookingTime"],
        avgPersonAmt:
            json["avgPersonAmt"] == null ? null : json["avgPersonAmt"],
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
        "cuisine": cuisine == null ? null : cuisine,
        "sortOrder": sortOrder == null ? null : sortOrder,
        "avgCookingTime": avgCookingTime == null ? null : avgCookingTime,
        "avgPersonAmt": avgPersonAmt == null ? null : avgPersonAmt,
        "storeLogo": storeLogo == null ? null : storeLogo.toJson(),
        "storeBg": storeBg == null ? null : storeBg.toJson(),
        "rating": rating == null ? null : rating,
        "distance": distance == null ? null : distance,
        "minimumOrderValue":
            minimumOrderValue == null ? null : minimumOrderValue,
      };
}

class QuickLocation {
  QuickLocation({
    this.address,
  });

  String address;

  factory QuickLocation.fromJson(Map<String, dynamic> json) => QuickLocation(
        address: json["address"] == null ? null : json["address"],
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
      };
}
