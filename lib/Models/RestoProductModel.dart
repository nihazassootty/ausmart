// To parse this JSON data, do
//
//     final restoProductModel = restoProductModelFromJson(jsonString);

import 'dart:convert';

RestoProductModel restoProductModelFromJson(String str) =>
    RestoProductModel.fromJson(json.decode(str));

String restoProductModelToJson(RestoProductModel data) =>
    json.encode(data.toJson());

class RestoProductModel {
  RestoProductModel({
    this.vendor,
    this.products,
  });

  Vendor vendor;
  List<RestoProductModelProduct> products;

  factory RestoProductModel.fromJson(Map<String, dynamic> json) =>
      RestoProductModel(
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        products: json["products"] == null
            ? null
            : List<RestoProductModelProduct>.from(json["products"]
                .map((x) => RestoProductModelProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vendor": vendor == null ? null : vendor.toJson(),
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class RestoProductModelProduct {
  RestoProductModelProduct({
    this.id,
    this.category,
    this.products,
  });

  String id;
  ProductCategory category;
  List<Product> products;

  factory RestoProductModelProduct.fromJson(Map<String, dynamic> json) =>
      RestoProductModelProduct(
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
    this.name,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.endTime,
    this.startTime,
    this.status,
  });

  String id;
  String name;
  String type;
  String createdAt;
  String updatedAt;
  dynamic v;
  String endTime;
  String startTime;
  bool status;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        endTime: json["endTime"] == null ? null : json["endTime"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
        "endTime": endTime == null ? null : endTime,
        "startTime": startTime == null ? null : startTime,
        "status": status == null ? null : status,
      };
}

class Product {
  Product({
    this.id,
    this.status,
    this.type,
    this.name,
    this.category,
    this.categoryType,
    this.meal,
    this.price,
    this.packingCharge,
    this.offerPrice,
    this.specialTag,
    this.ausmartPrice,
    this.description,
    this.branch,
    this.vendor,
    this.image,
    this.bestSeller,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.addons,
    this.addonStatus,
    this.showAddon,
    this.ids,
  });

  String id;
  String ids;
  bool status;
  String type;
  String name;
  String category;
  String categoryType;
  String meal;
  dynamic price;
  dynamic packingCharge;
  dynamic offerPrice;
  String specialTag;
  dynamic ausmartPrice;
  String description;
  String branch;
  String vendor;
  StoreBg image;
  bool bestSeller;
  String createdAt;
  String updatedAt;
  List<Addons> addons;
  bool addonStatus;
  bool showAddon;

  dynamic v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"] == null ? null : json["_id"],
        ids: json["id"] == null ? null : json["id"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        name: json["name"] == null ? null : json["name"],
        category: json["category"] == null ? null : json["category"],
        categoryType:
            json["categoryType"] == null ? null : json["categoryType"],
        meal: json["meal"] == null ? null : json["meal"],
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
        image: json["image"] == null ? null : StoreBg.fromJson(json["image"]),
        bestSeller: json["bestSeller"] == null ? null : json["bestSeller"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        addons: json["addons"] == null
            ? null
            : List<Addons>.from(json["addons"].map((x) => Addons.fromJson(x))),
        addonStatus: json["addonStatus"] == null ? null : json["addonStatus"],
        showAddon: json["showAddon"] == null ? null : json["showAddon"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "id": ids == null ? null : ids,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "name": name == null ? null : name,
        "category": category == null ? null : category,
        "categoryType": categoryType == null ? null : categoryType,
        "meal": meal == null ? null : meal,
        "price": price == null ? null : price,
        "packingCharge": packingCharge == null ? null : packingCharge,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "specialTag": specialTag == null ? null : specialTag,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "description": description == null ? null : description,
        "branch": branch == null ? null : branch,
        "vendor": vendor == null ? null : vendor,
        "image": image == null ? null : image.toJson(),
        "bestSeller": bestSeller == null ? null : bestSeller,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "addonStatus": addonStatus == null ? null : addonStatus,
        "__v": v == null ? null : v,
        "showAddon": showAddon == null ? null : showAddon,
        "addons": addons == null
            ? null
            : List<dynamic>.from(addons.map((x) => x.toJson())),
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
    this.cuisine,
    this.commission,
    this.dCommission,
    this.sortOrder,
    this.avgCookingTime,
    this.avgPersonAmt,
    this.gst,
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
  String cuisine;
  dynamic commission;
  dynamic dCommission;
  dynamic sortOrder;
  dynamic avgCookingTime;
  dynamic avgPersonAmt;
  String gst;
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
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        minimumOrderValue: json["minimumOrderValue"] == null
            ? null
            : json["minimumOrderValue"],
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
        "cuisine": cuisine == null ? null : cuisine,
        "commission": commission == null ? null : commission,
        "dCommission": dCommission == null ? null : dCommission,
        "sortOrder": sortOrder == null ? null : sortOrder,
        "avgCookingTime": avgCookingTime == null ? null : avgCookingTime,
        "avgPersonAmt": avgPersonAmt == null ? null : avgPersonAmt,
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
        "minimumOrderValue":
            minimumOrderValue == null ? null : minimumOrderValue,
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
