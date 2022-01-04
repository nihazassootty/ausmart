// To parse this JSON data, do
//
//     final marketProductModel = marketProductModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MarketProductModel marketProductModelFromJson(String str) =>
    MarketProductModel.fromJson(json.decode(str));

String marketProductModelToJson(MarketProductModel data) =>
    json.encode(data.toJson());

class MarketProductModel {
  MarketProductModel({
    @required this.vendor,
    @required this.products,
  });

  final Vendor vendor;
  final List<MarketProductModelProduct> products;

  factory MarketProductModel.fromJson(Map<String, dynamic> json) =>
      MarketProductModel(
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        products: json["products"] == null
            ? null
            : List<MarketProductModelProduct>.from(json["products"]
                .map((x) => MarketProductModelProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vendor": vendor == null ? null : vendor.toJson(),
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class MarketProductModelProduct {
  MarketProductModelProduct({
    @required this.id,
    @required this.category,
    @required this.products,
  });

  final String id;
  final ProductCategory category;
  final List<ProductProduct> products;

  factory MarketProductModelProduct.fromJson(Map<String, dynamic> json) =>
      MarketProductModelProduct(
        id: json["_id"] == null ? null : json["_id"],
        category: json["category"] == null
            ? null
            : ProductCategory.fromJson(json["category"]),
        products: json["products"] == null
            ? null
            : List<ProductProduct>.from(
                json["products"].map((x) => ProductProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "category": category == null ? null : category.toJson(),
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductCategory {
  ProductCategory({
    @required this.id,
    @required this.status,
    @required this.name,
    @required this.type,
    @required this.branch,
    @required this.image,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.v,
  });

  final String id;
  final bool status;
  final String name;
  final String type;
  final String branch;
  final StoreBg image;
  final String createdAt;
  final String updatedAt;
  final dynamic v;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["_id"] == null ? null : json["_id"],
        status: json["status"] == null ? null : json["status"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        branch: json["branch"] == null ? null : json["branch"],
        image: json["image"] == null ? null : StoreBg.fromJson(json["image"]),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "status": status == null ? null : status,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "branch": branch == null ? null : branch,
        "image": image == null ? null : image.toJson(),
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
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

class ProductProduct {
  ProductProduct({
    @required this.id,
    @required this.status,
    @required this.type,
    @required this.name,
    @required this.category,
    @required this.price,
    @required this.packingCharge,
    @required this.offerPrice,
    @required this.specialTag,
    @required this.ausmartPrice,
    @required this.description,
    @required this.branch,
    @required this.vendor,
    @required this.image,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.v,
    @required this.bestSeller,
    @required this.showAddon,
    @required this.addons,
    @required this.ids,
  });

  final String id;
  String ids;

  final bool status;
  final String type;
  final String name;
  final String category;
  final dynamic price;
  final dynamic packingCharge;
  final dynamic offerPrice;
  final String specialTag;
  final dynamic ausmartPrice;
  final String description;
  final String branch;
  List<Addons> addons;
  bool showAddon;

  final String vendor;
  final StoreBg image;
  final String createdAt;
  final String updatedAt;
  final dynamic v;
  final bool bestSeller;

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["_id"] == null ? null : json["_id"],
        ids: json["id"] == null ? null : json["id"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        name: json["name"] == null ? null : json["name"],
        category: json["category"] == null ? null : json["category"],
        price: json["price"] == null ? null : json["price"],
        packingCharge: json["packingCharge"],
        offerPrice: json["offerPrice"],
        specialTag: json["specialTag"] == null ? null : json["specialTag"],
        ausmartPrice:
            json["ausmartPrice"] == null ? null : json["ausmartPrice"],
        description: json["description"] == null ? null : json["description"],
        branch: json["branch"] == null ? null : json["branch"],
        vendor: json["vendor"] == null ? null : json["vendor"],
        image: json["image"] == null ? null : StoreBg.fromJson(json["image"]),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        showAddon: json["showAddon"] == null ? null : json["showAddon"],
        addons: json["addons"] == null
            ? null
            : List<Addons>.from(json["addons"].map((x) => Addons.fromJson(x))),
        v: json["__v"] == null ? null : json["__v"],
        bestSeller: json["bestSeller"] == null ? null : json["bestSeller"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "id": ids == null ? null : ids,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "name": name == null ? null : name,
        "category": category == null ? null : category,
        "price": price == null ? null : price,
        "packingCharge": packingCharge,
        "offerPrice": offerPrice,
        "specialTag": specialTag == null ? null : specialTag,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "description": description == null ? null : description,
        "branch": branch == null ? null : branch,
        "vendor": vendor == null ? null : vendor,
        "image": image == null ? null : image.toJson(),
        "createdAt": createdAt == null ? null : createdAt,
        "showAddon": showAddon == null ? null : showAddon,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
        "bestSeller": bestSeller == null ? null : bestSeller,
      };
}

class Vendor {
  Vendor({
    @required this.storeLogo,
    @required this.storeBg,
    @required this.location,
    @required this.contactNumber,
    @required this.quickDelivery,
    @required this.storeStatus,
    @required this.addons,
    @required this.featured,
    @required this.rating,
    @required this.id,
    @required this.name,
    @required this.branch,
    @required this.type,
    @required this.openTime,
    @required this.closeTime,
    @required this.commission,
    @required this.dCommission,
    @required this.sortOrder,
    @required this.gst,
    @required this.fssai,
    @required this.user,
    @required this.storeBanner,
    @required this.category,
    @required this.createdAt,
    @required this.updatedAt,
        this.minimumOrderValue,

    @required this.v,
  });

  final StoreBg storeLogo;
  final StoreBg storeBg;
  final Location location;
  final dynamic contactNumber;
  final bool quickDelivery;
  final bool storeStatus;
  final List<dynamic> addons;
  final bool featured;
  final dynamic rating;
  final String id;
  final String name;
  final String branch;
  final String type;
  final String openTime;
  final String closeTime;
  final dynamic commission;
  final dynamic dCommission;
  final dynamic sortOrder;
  final String gst;
  final String fssai;
  final String user;
  final List<dynamic> storeBanner;
  final List<CategoryElement> category;
  final String createdAt;
  final String updatedAt;
  final dynamic v;
  int minimumOrderValue;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        storeLogo: json["storeLogo"] == null
            ? null
            : StoreBg.fromJson(json["storeLogo"]),
        storeBg:
            json["storeBg"] == null ? null : StoreBg.fromJson(json["storeBg"]),
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
         minimumOrderValue: json["minimumOrderValue"] == null
            ? null
            : json["minimumOrderValue"],
        rating: json["rating"] == null ? null : json["rating"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : json["branch"],
        type: json["type"] == null ? null : json["type"],
        openTime: json["openTime"] == null ? null : json["openTime"],
        closeTime: json["closeTime"] == null ? null : json["closeTime"],
        commission: json["commission"] == null ? null : json["commission"],
        dCommission: json["dCommission"] == null ? null : json["dCommission"],
        sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
        gst: json["gst"] == null ? null : json["gst"],
        fssai: json["fssai"] == null ? null : json["fssai"],
        user: json["user"] == null ? null : json["user"],
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
      );

  Map<String, dynamic> toJson() => {
        "storeLogo": storeLogo == null ? null : storeLogo.toJson(),
        "storeBg": storeBg == null ? null : storeBg.toJson(),
        "location": location == null ? null : location.toJson(),
        "contactNumber": contactNumber == null ? null : contactNumber,
        "quickDelivery": quickDelivery == null ? null : quickDelivery,
        "storeStatus": storeStatus == null ? null : storeStatus,
        "addons":
            addons == null ? null : List<dynamic>.from(addons.map((x) => x)),
        "featured": featured == null ? null : featured,
        "rating": rating == null ? null : rating,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "branch": branch == null ? null : branch,
        "type": type == null ? null : type,
        "openTime": openTime == null ? null : openTime,
        "closeTime": closeTime == null ? null : closeTime,
        "minimumOrderValue":
            minimumOrderValue == null ? null : minimumOrderValue,
        "commission": commission == null ? null : commission,
        "dCommission": dCommission == null ? null : dCommission,
        "sortOrder": sortOrder == null ? null : sortOrder,
        "gst": gst == null ? null : gst,
        "fssai": fssai == null ? null : fssai,
        "user": user == null ? null : user,
        "storeBanner": storeBanner == null
            ? null
            : List<dynamic>.from(storeBanner.map((x) => x)),
        "category": category == null
            ? null
            : List<dynamic>.from(category.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
      };
}

class CategoryElement {
  CategoryElement({
    @required this.status,
    @required this.id,
    @required this.category,
  });

  final bool status;
  final String id;
  final String category;

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
    @required this.type,
    @required this.formattedAddress,
    @required this.address,
    @required this.coordinates,
    @required this.landmark,
  });

  final String type;
  final String formattedAddress;
  final String address;
  final List<double> coordinates;
  final String landmark;

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

class Addons {
  Addons({
    this.id,
    this.price,
    this.name,
    this.status,
    this.offerPrice,
    this.ausmartPrice,
  });

  String id;
  String name;
  dynamic price;
  bool status;
  dynamic offerPrice;
  dynamic ausmartPrice;

  factory Addons.fromJson(Map<String, dynamic> json) => Addons(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
        ausmartPrice:
            json["ausmartPrice"] == null ? null : json["ausmartPrice"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "_id": id == null ? null : id,
        "price": price == null ? null : price,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "status": status == null ? null : status,
      };
}
