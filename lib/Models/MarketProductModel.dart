// To parse this JSON data, do
//
//     final marketProductModel = marketProductModelFromJson(jsonString);

import 'dart:convert';

MarketProductModel marketProductModelFromJson(String str) =>
    MarketProductModel.fromJson(json.decode(str));

String marketProductModelToJson(MarketProductModel data) =>
    json.encode(data.toJson());

class MarketProductModel {
  MarketProductModel({
    this.vendor,
    this.products,
  });

  Vendor vendor;
  List<MarketProductModelProduct> products;

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
    this.id,
    this.category,
    this.products,
  });

  String id;
  ProductCategory category;
  List<Product> products;

  factory MarketProductModelProduct.fromJson(Map<String, dynamic> json) =>
      MarketProductModelProduct(
        id: json["_id"] == null ? null : json["_id"],
        category: json["category"] == null
            ? null
            : ProductCategory.fromJson(json["category"]),
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
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
    this.id,
    this.status,
    this.name,
    this.type,
    this.branch,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  bool status;
  String name;
  String type;
  String branch;
  StoreBg image;
  String createdAt;
  String updatedAt;
  dynamic v;

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

class Product {
  Product({
    this.id,
    this.status,
    this.type,
    this.name,
    this.category,
    this.price,
    this.packingCharge,
    this.offerPrice,
    this.specialTag,
    this.ausmartPrice,
    this.description,
    this.branch,
    this.vendor,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
    this.bestSeller,
  });

  String id;
  bool status;
  String type;
  String name;
  String category;
  dynamic price;
  dynamic packingCharge;
  dynamic offerPrice;
  String specialTag;
  dynamic ausmartPrice;
  String description;
  String branch;
  String vendor;
  String createdAt;
  String updatedAt;
  dynamic v;
  StoreBg image;
  bool bestSeller;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"] == null ? null : json["_id"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        name: json["name"] == null ? null : json["name"],
        category: json["category"] == null ? null : json["category"],
        price: json["price"] == null ? null : json["price"],
        packingCharge:
            json["packingCharge"] == null ? null : json["packingCharge"],
        offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
        specialTag: json["specialTag"] == null ? null : json["specialTag"],
        ausmartPrice:
            json["ausmartPrice"] == null ? null : json["ausmartPrice"],
        description: json["description"] == null ? null : json["description"],
        branch: json["branch"] == null ? null : json["branch"],
        vendor: json["vendor"] == null ? null : json["vendor"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        image: json["image"] == null ? null : StoreBg.fromJson(json["image"]),
        bestSeller: json["bestSeller"] == null ? null : json["bestSeller"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "name": name == null ? null : name,
        "category": category == null ? null : category,
        "price": price == null ? null : price,
        "packingCharge": packingCharge == null ? null : packingCharge,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "specialTag": specialTag == null ? null : specialTag,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "description": description == null ? null : description,
        "branch": branch == null ? null : branch,
        "vendor": vendor == null ? null : vendor,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
        "image": image == null ? null : image.toJson(),
        "bestSeller": bestSeller == null ? null : bestSeller,
      };
}

class Vendor {
  Vendor({
    this.storeLogo,
    this.storeBg,
    this.location,
    this.contactNumber,
    this.quickDelivery,
    this.storeStatus,
    this.addons,
    this.featured,
    this.rating,
    this.id,
    this.name,
    this.branch,
    this.type,
    this.openTime,
    this.closeTime,
    this.commission,
    this.dCommission,
    this.sortOrder,
    this.fssai,
    this.user,
    this.storeBanner,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.minimumOrderValue,
  });

  StoreBg storeLogo;
  StoreBg storeBg;
  Location location;
  dynamic contactNumber;
  bool quickDelivery;
  bool storeStatus;
  List<dynamic> addons;
  bool featured;
  dynamic rating;
  String id;
  String name;
  String branch;
  String type;
  String openTime;
  String closeTime;
  dynamic commission;
  dynamic dCommission;
  dynamic sortOrder;
  String fssai;
  String user;
  List<dynamic> storeBanner;
  List<CategoryElement> category;
  String createdAt;
  String updatedAt;
  dynamic v;
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
        rating: json["rating"] == null ? null : json["rating"],
        minimumOrderValue: json["minimumOrderValue"] == null
            ? null
            : json["minimumOrderValue"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : json["branch"],
        type: json["type"] == null ? null : json["type"],
        openTime: json["openTime"] == null ? null : json["openTime"],
        closeTime: json["closeTime"] == null ? null : json["closeTime"],
        commission: json["commission"] == null ? null : json["commission"],
        dCommission: json["dCommission"] == null ? null : json["dCommission"],
        sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
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
        "commission": commission == null ? null : commission,
        "dCommission": dCommission == null ? null : dCommission,
        "sortOrder": sortOrder == null ? null : sortOrder,
        "minimumOrderValue":
            minimumOrderValue == null ? null : minimumOrderValue,
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
