// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StoreModel storeModelFromJson(String str) => StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
    StoreModel({
        @required this.branch,
        @required this.quick,
        @required this.restaurant,
    });

    final Branch branch;
    final List<Quick> quick;
    final List<Quick> restaurant;

    factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        quick: json["quick"] == null ? null : List<Quick>.from(json["quick"].map((x) => Quick.fromJson(x))),
        restaurant: json["restaurant"] == null ? null : List<Quick>.from(json["restaurant"].map((x) => Quick.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "branch": branch == null ? null : branch.toJson(),
        "quick": quick == null ? null : List<dynamic>.from(quick.map((x) => x.toJson())),
        "restaurant": restaurant == null ? null : List<dynamic>.from(restaurant.map((x) => x.toJson())),
    };
}

class Branch {
    Branch({
        @required this.id,
        @required this.location,
        @required this.status,
        @required this.radius,
        @required this.name,
        @required this.supportNumber,
        @required this.offers,
        @required this.branchBanner,
        @required this.branchMiddleBanner,
        @required this.distance,
    });

    final String id;
    final BranchLocation location;
    final bool status;
    final dynamic radius;
    final String name;
    final dynamic supportNumber;
    final List<dynamic> offers;
    final List<BranchBanner> branchBanner;
    final List<BranchBanner> branchMiddleBanner;
    final dynamic distance;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null ? null : BranchLocation.fromJson(json["location"]),
        status: json["status"] == null ? null : json["status"],
        radius: json["radius"] == null ? null : json["radius"],
        name: json["name"] == null ? null : json["name"],
        supportNumber: json["supportNumber"] == null ? null : json["supportNumber"],
        offers: json["offers"] == null ? null : List<dynamic>.from(json["offers"].map((x) => x)),
        branchBanner: json["branchBanner"] == null ? null : List<BranchBanner>.from(json["branchBanner"].map((x) => BranchBanner.fromJson(x))),
        branchMiddleBanner: json["branchMiddleBanner"] == null ? null : List<BranchBanner>.from(json["branchMiddleBanner"].map((x) => BranchBanner.fromJson(x))),
        distance: json["distance"] == null ? null : json["distance"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location.toJson(),
        "status": status == null ? null : status,
        "radius": radius == null ? null : radius,
        "name": name == null ? null : name,
        "supportNumber": supportNumber == null ? null : supportNumber,
        "offers": offers == null ? null : List<dynamic>.from(offers.map((x) => x)),
        "branchBanner": branchBanner == null ? null : List<dynamic>.from(branchBanner.map((x) => x.toJson())),
        "branchMiddleBanner": branchMiddleBanner == null ? null : List<dynamic>.from(branchMiddleBanner.map((x) => x.toJson())),
        "distance": distance == null ? null : distance,
    };
}

class BranchBanner {
    BranchBanner({
        @required this.clickable,
        @required this.id,
        @required this.linkId,
        @required this.image,
    });

    final bool clickable;
    final String id;
    final String linkId;
    final StoreBg image;

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
        @required this.key,
        @required this.image,
    });

    final String key;
    final String image;

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
        @required this.type,
        @required this.coordinates,
        @required this.address,
    });

    final String type;
    final List<double> coordinates;
    final String address;

    factory BranchLocation.fromJson(Map<String, dynamic> json) => BranchLocation(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        address: json["address"] == null ? null : json["address"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
        "address": address == null ? null : address,
    };
}

class Quick {
    Quick({
        @required this.id,
        @required this.location,
        @required this.quickDelivery,
        @required this.storeStatus,
        @required this.featured,
        @required this.rating,
        @required this.name,
        @required this.branch,
        @required this.openTime,
        @required this.closeTime,
        @required this.cuisine,
        @required this.sortOrder,
        @required this.avgCookingTime,
        @required this.avgPersonAmt,
        @required this.storeLogo,
        @required this.storeBg,
        @required this.distance,
    });

    final String id;
    final QuickLocation location;
    final bool quickDelivery;
    final bool storeStatus;
    final bool featured;
    final dynamic rating;
    final String name;
    final String branch;
    final String openTime;
    final String closeTime;
    final String cuisine;
    final dynamic sortOrder;
    final dynamic avgCookingTime;
    final dynamic avgPersonAmt;
    final StoreBg storeLogo;
    final StoreBg storeBg;
    final double distance;

    factory Quick.fromJson(Map<String, dynamic> json) => Quick(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null ? null : QuickLocation.fromJson(json["location"]),
        quickDelivery: json["quickDelivery"] == null ? null : json["quickDelivery"],
        storeStatus: json["storeStatus"] == null ? null : json["storeStatus"],
        featured: json["featured"] == null ? null : json["featured"],
        rating: json["rating"] == null ? null : json["rating"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : json["branch"],
        openTime: json["openTime"] == null ? null : json["openTime"],
        closeTime: json["closeTime"] == null ? null : json["closeTime"],
        cuisine: json["cuisine"] == null ? null : json["cuisine"],
        sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
        avgCookingTime: json["avgCookingTime"] == null ? null : json["avgCookingTime"],
        avgPersonAmt: json["avgPersonAmt"] == null ? null : json["avgPersonAmt"],
        storeLogo: json["storeLogo"] == null ? null : StoreBg.fromJson(json["storeLogo"]),
        storeBg: json["storeBg"] == null ? null : StoreBg.fromJson(json["storeBg"]),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location.toJson(),
        "quickDelivery": quickDelivery == null ? null : quickDelivery,
        "storeStatus": storeStatus == null ? null : storeStatus,
        "featured": featured == null ? null : featured,
        "rating": rating == null ? null : rating,
        "name": name == null ? null : name,
        "branch": branch == null ? null : branch,
        "openTime": openTime == null ? null : openTime,
        "closeTime": closeTime == null ? null : closeTime,
        "cuisine": cuisine == null ? null : cuisine,
        "sortOrder": sortOrder == null ? null : sortOrder,
        "avgCookingTime": avgCookingTime == null ? null : avgCookingTime,
        "avgPersonAmt": avgPersonAmt == null ? null : avgPersonAmt,
        "storeLogo": storeLogo == null ? null : storeLogo.toJson(),
        "storeBg": storeBg == null ? null : storeBg.toJson(),
        "distance": distance == null ? null : distance,
    };
}

class QuickLocation {
    QuickLocation({
        @required this.address,
    });

    final String address;

    factory QuickLocation.fromJson(Map<String, dynamic> json) => QuickLocation(
        address: json["address"] == null ? null : json["address"],
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
    };
}
