// To parse this JSON data, do
//
//     final popularInnerModel = popularInnerModelFromJson(jsonString);

import 'dart:convert';

PopularInnerModel popularInnerModelFromJson(String str) =>
    PopularInnerModel.fromJson(json.decode(str));

String popularInnerModelToJson(PopularInnerModel data) =>
    json.encode(data.toJson());

class PopularInnerModel {
  PopularInnerModel({
    this.category,
    this.stores,
  });

  PopularInnerModelCategory category;
  List<Store> stores;

  factory PopularInnerModel.fromJson(Map<String, dynamic> json) =>
      PopularInnerModel(
        category: json["category"] == null
            ? null
            : PopularInnerModelCategory.fromJson(json["category"]),
        stores: json["stores"] == null
            ? null
            : List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category == null ? null : category.toJson(),
        "stores": stores == null
            ? null
            : List<dynamic>.from(stores.map((x) => x.toJson())),
      };
}

class PopularInnerModelCategory {
  PopularInnerModelCategory({
    this.image,
    this.banner,
    this.id,
    this.name,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.description,
  });

  Banner image;
  Banner banner;
  String id;
  String name;
  String type;
  String createdAt;
  String updatedAt;
  dynamic v;
  String description;

  factory PopularInnerModelCategory.fromJson(Map<String, dynamic> json) =>
      PopularInnerModelCategory(
        image: json["image"] == null ? null : Banner.fromJson(json["image"]),
        banner: json["banner"] == null ? null : Banner.fromJson(json["banner"]),
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image.toJson(),
        "banner": banner == null ? null : banner.toJson(),
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
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

class Store {
  Store({
    this.id,
    this.location,
    this.contactNumber,
    this.quickDelivery,
    this.storeStatus,
    this.addons,
    this.featured,
    this.name,
    this.branch,
    this.type,
    this.openTime,
    this.closeTime,
    this.cuisine,
    this.commission,
    this.dCommission,
    this.sortOrder,
    this.avgCookingTime,
    this.avgPersonAmt,
    this.gst,
    this.fssai,
    this.user,
    this.storeLogo,
    this.storeBg,
    this.storeBanner,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.rating,
    this.minimumOrderValue,
  });

  String id;
  Location location;
  dynamic contactNumber;
  bool quickDelivery;
  bool storeStatus;
  List<dynamic> addons;
  bool featured;
  String name;
  String branch;
  String type;
  String openTime;
  String closeTime;
  String cuisine;
  dynamic commission;
  dynamic dCommission;
  dynamic sortOrder;
  dynamic avgCookingTime;
  dynamic avgPersonAmt;
  String gst;
  String fssai;
  String user;
  Banner storeLogo;
  Banner storeBg;
  List<dynamic> storeBanner;
  List<CategoryElement> category;
  String createdAt;
  String updatedAt;
  dynamic v;
  dynamic rating;
  int minimumOrderValue;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        contactNumber:
            json["contactNumber"] == null ? null : json["contactNumber"],
        quickDelivery:
            json["quickDelivery"] == null ? null : json["quickDelivery"],
        storeStatus: json["storeStatus"] == null ? null : json["storeStatus"],
        addons: json["addons"] == null
            ? null
            : List<dynamic>.from(json["addons"].map((x) => x)),
        featured: json["featured"] == null ? null : json["featured"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : json["branch"],
        type: json["type"] == null ? null : json["type"],
        openTime: json["openTime"] == null ? null : json["openTime"],
        closeTime: json["closeTime"] == null ? null : json["closeTime"],
        cuisine: json["cuisine"] == null ? null : json["cuisine"],
        commission: json["commission"] == null ? null : json["commission"],
        dCommission: json["dCommission"] == null ? null : json["dCommission"],
        sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
        avgCookingTime:
            json["avgCookingTime"] == null ? null : json["avgCookingTime"],
        avgPersonAmt:
            json["avgPersonAmt"] == null ? null : json["avgPersonAmt"],
        gst: json["gst"] == null ? null : json["gst"],
        fssai: json["fssai"] == null ? null : json["fssai"],
        user: json["user"] == null ? null : json["user"],
        storeLogo: json["storeLogo"] == null
            ? null
            : Banner.fromJson(json["storeLogo"]),
        storeBg:
            json["storeBg"] == null ? null : Banner.fromJson(json["storeBg"]),
        storeBanner: json["storeBanner"] == null
            ? null
            : List<dynamic>.from(json["storeBanner"].map((x) => x)),
        category: json["category"] == null
            ? null
            : List<CategoryElement>.from(
                json["category"].map((x) => CategoryElement.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        rating: json["rating"] == null ? null : json["rating"],
    minimumOrderValue: json["minimumOrderValue"] == null ? null : json["minimumOrderValue"],

  );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location.toJson(),
        "contactNumber": contactNumber == null ? null : contactNumber,
        "quickDelivery": quickDelivery == null ? null : quickDelivery,
        "storeStatus": storeStatus == null ? null : storeStatus,
        "addons":
            addons == null ? null : List<dynamic>.from(addons.map((x) => x)),
        "featured": featured == null ? null : featured,
        "name": name == null ? null : name,
        "branch": branch == null ? null : branch,
        "type": type == null ? null : type,
        "openTime": openTime == null ? null : openTime,
        "closeTime": closeTime == null ? null : closeTime,
        "cuisine": cuisine == null ? null : cuisine,
        "commission": commission == null ? null : commission,
        "dCommission": dCommission == null ? null : dCommission,
        "sortOrder": sortOrder == null ? null : sortOrder,
        "avgCookingTime": avgCookingTime == null ? null : avgCookingTime,
        "avgPersonAmt": avgPersonAmt == null ? null : avgPersonAmt,
        "gst": gst == null ? null : gst,
        "fssai": fssai == null ? null : fssai,
        "user": user == null ? null : user,
        "storeLogo": storeLogo == null ? null : storeLogo.toJson(),
        "storeBg": storeBg == null ? null : storeBg.toJson(),
        "storeBanner": storeBanner == null
            ? null
            : List<dynamic>.from(storeBanner.map((x) => x)),
        "category": category == null
            ? null
            : List<dynamic>.from(category.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
        "rating": rating == null ? null : rating,
    "minimumOrderValue": minimumOrderValue == null ? null : minimumOrderValue,

  };
}

class CategoryElement {
  CategoryElement({
    this.status,
    this.id,
    this.category,
  });

  bool status;
  String id;
  String category;

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        status: json["status"] == null ? null : json["status"],
        id: json["_id"] == null ? null : json["_id"],
        category: json["category"] == null ? null : json["category"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "_id": id == null ? null : id,
        "category": category == null ? null : category,
      };
}

class Location {
  Location({
    this.type,
    this.formattedAddress,
    this.address,
    this.coordinates,
    this.landmark,
  });

  String type;
  String formattedAddress;
  String address;
  List<double> coordinates;
  String landmark;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"] == null ? null : json["type"],
        formattedAddress:
            json["formattedAddress"] == null ? null : json["formattedAddress"],
        address: json["address"] == null ? null : json["address"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        landmark: json["landmark"] == null ? null : json["landmark"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "formattedAddress": formattedAddress == null ? null : formattedAddress,
        "address": address == null ? null : address,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
        "landmark": landmark == null ? null : landmark,
      };
}
