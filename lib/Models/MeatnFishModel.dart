// To parse this JSON data, do
//
//     final meantnFishModel = meantnFishModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MeantnFishModel meantnFishModelFromJson(String str) => MeantnFishModel.fromJson(json.decode(str));

String meantnFishModelToJson(MeantnFishModel data) => json.encode(data.toJson());

class MeantnFishModel {
    MeantnFishModel({
        @required this.success,
        @required this.pagination,
        @required this.data,
    });

    final bool success;
    final Pagination pagination;
    final Data data;

    factory MeantnFishModel.fromJson(Map<String, dynamic> json) => MeantnFishModel(
        success: json["success"] == null ? null : json["success"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "pagination": pagination == null ? null : pagination.toJson(),
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        @required this.branch,
        @required this.stores,
    });

    final Branch branch;
    final List<Store> stores;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        stores: json["stores"] == null ? null : List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "branch": branch == null ? null : branch.toJson(),
        "stores": stores == null ? null : List<dynamic>.from(stores.map((x) => x.toJson())),
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
        @required this.distance,
    });

    final String id;
    final BranchLocation location;
    final bool status;
    final int radius;
    final String name;
    final int supportNumber;
    final List<dynamic> offers;
    final List<BranchBanner> branchBanner;
    final double distance;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null ? null : BranchLocation.fromJson(json["location"]),
        status: json["status"] == null ? null : json["status"],
        radius: json["radius"] == null ? null : json["radius"],
        name: json["name"] == null ? null : json["name"],
        supportNumber: json["supportNumber"] == null ? null : json["supportNumber"],
        offers: json["offers"] == null ? null : List<dynamic>.from(json["offers"].map((x) => x)),
        branchBanner: json["branchBanner"] == null ? null : List<BranchBanner>.from(json["branchBanner"].map((x) => BranchBanner.fromJson(x))),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
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
        "distance": distance == null ? null : distance,
    };
}

class BranchBanner {
    BranchBanner({
        @required this.clickable,
        @required this.id,
        @required this.image,
    });

    final bool clickable;
    final String id;
    final StoreBg image;

    factory BranchBanner.fromJson(Map<String, dynamic> json) => BranchBanner(
        clickable: json["clickable"] == null ? null : json["clickable"],
        id: json["_id"] == null ? null : json["_id"],
        image: json["image"] == null ? null : StoreBg.fromJson(json["image"]),
    );

    Map<String, dynamic> toJson() => {
        "clickable": clickable == null ? null : clickable,
        "_id": id == null ? null : id,
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

class Store {
    Store({
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
        @required this.sortOrder,
        @required this.storeLogo,
        @required this.storeBg,
        @required this.distance,
    });

    final String id;
    final StoreLocation location;
    final bool quickDelivery;
    final bool storeStatus;
    final bool featured;
    final int rating;
    final String name;
    final String branch;
    final String openTime;
    final String closeTime;
    final int sortOrder;
    final StoreBg storeLogo;
    final StoreBg storeBg;
    final double distance;

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null ? null : StoreLocation.fromJson(json["location"]),
        quickDelivery: json["quickDelivery"] == null ? null : json["quickDelivery"],
        storeStatus: json["storeStatus"] == null ? null : json["storeStatus"],
        featured: json["featured"] == null ? null : json["featured"],
        rating: json["rating"] == null ? null : json["rating"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : json["branch"],
        openTime: json["openTime"] == null ? null : json["openTime"],
        closeTime: json["closeTime"] == null ? null : json["closeTime"],
        sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
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
        "sortOrder": sortOrder == null ? null : sortOrder,
        "storeLogo": storeLogo == null ? null : storeLogo.toJson(),
        "storeBg": storeBg == null ? null : storeBg.toJson(),
        "distance": distance == null ? null : distance,
    };
}

class StoreLocation {
    StoreLocation({
        @required this.address,
    });

    final String address;

    factory StoreLocation.fromJson(Map<String, dynamic> json) => StoreLocation(
        address: json["address"] == null ? null : json["address"],
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
    };
}

class Pagination {
    Pagination();

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    );

    Map<String, dynamic> toJson() => {
    };
}
