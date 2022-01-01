// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.products,
    this.vendors,
  });

  Products products;
  Vendors vendors;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        products: json["products"] == null
            ? null
            : Products.fromJson(json["products"]),
        vendors:
            json["vendors"] == null ? null : Vendors.fromJson(json["vendors"]),
      );

  Map<String, dynamic> toJson() => {
        "products": products == null ? null : products.toJson(),
        "vendors": vendors == null ? null : vendors.toJson(),
      };
}

class Products {
  Products({
    this.count,
    this.products,
  });

  int count;
  List<Product> products;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        count: json["count"] == null ? null : json["count"],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.status,
    this.type,
    this.name,
    this.price,
    this.offerPrice,
    this.ausmartPrice,
    this.vendor,
    this.image,
  });

  String id;
  bool status;
  String type;
  String name;
  int price;
  int offerPrice;
  double ausmartPrice;
  Vendor vendor;
  Picture image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"] == null ? null : json["_id"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
        ausmartPrice: json["ausmartPrice"] == null
            ? null
            : json["ausmartPrice"].toDouble(),
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        image: json["image"] == null ? null : Picture.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "vendor": vendor == null ? null : vendor.toJson(),
        "image": image == null ? null : image.toJson(),
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

class Vendor {
  Vendor({
    this.id,
    this.name,
    this.branch,
  });

  String id;
  String name;
  String branch;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : json["branch"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "branch": branch == null ? null : branch,
      };
}

class Vendors {
  Vendors({
    this.count,
    this.restaurants,
  });

  int count;
  List<Restaurant> restaurants;

  factory Vendors.fromJson(Map<String, dynamic> json) => Vendors(
        count: json["count"] == null ? null : json["count"],
        restaurants: json["restaurants"] == null
            ? null
            : List<Restaurant>.from(
                json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "restaurants": restaurants == null
            ? null
            : List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.location,
    this.storeStatus,
    this.name,
    this.branch,
    this.type,
    this.storeLogo,
    this.storeBanner,
  });

  String id;
  Location location;
  bool storeStatus;
  String name;
  String branch;
  String type;
  Picture storeLogo;
  List<dynamic> storeBanner;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        storeStatus: json["storeStatus"] == null ? null : json["storeStatus"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : json["branch"],
        type: json["type"] == null ? null : json["type"],
        storeLogo: json["storeLogo"] == null
            ? null
            : Picture.fromJson(json["storeLogo"]),
        storeBanner: json["storeBanner"] == null
            ? null
            : List<dynamic>.from(json["storeBanner"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location.toJson(),
        "storeStatus": storeStatus == null ? null : storeStatus,
        "name": name == null ? null : name,
        "branch": branch == null ? null : branch,
        "type": type == null ? null : type,
        "storeLogo": storeLogo == null ? null : storeLogo.toJson(),
        "storeBanner": storeBanner == null
            ? null
            : List<dynamic>.from(storeBanner.map((x) => x)),
      };
}

class Location {
  Location({
    this.address,
  });

  String address;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"] == null ? null : json["address"],
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
      };
}
