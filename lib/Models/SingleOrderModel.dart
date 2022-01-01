// To parse this JSON data, do
//
//     final singleOrderModel = singleOrderModelFromJson(jsonString);

import 'dart:convert';

SingleOrderModel singleOrderModelFromJson(String str) =>
    SingleOrderModel.fromJson(json.decode(str));

String singleOrderModelToJson(SingleOrderModel data) =>
    json.encode(data.toJson());

class SingleOrderModel {
  SingleOrderModel({
    this.commissionDetail,
    this.orderNote,
    this.orderStatus,
    this.status,
    this.track,
    this.id,
    this.vendor,
    this.vendorType,
    this.items,
    this.contactNumber,
    this.deliveryCharge,
    this.discount,
    this.paymentType,
    this.address,
    this.customer,
    this.totalPackingAmount,
    this.subTotalAmount,
    this.deliveryTip,
    this.branch,
    this.totalAmount,
    this.vendorTotalAmount,
    this.vendorCommissionTotal,
    this.deliveryDistanceKm,
    this.deliveryDistance,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.deliveryBoy,
  });

  CommissionDetail commissionDetail;
  List<dynamic> orderNote;
  String orderStatus;
  List<Status> status;
  List<Track> track;
  String id;
  Vendor vendor;
  String vendorType;
  List<Item> items;
  String contactNumber;
  dynamic deliveryCharge;
  dynamic discount;
  String paymentType;
  Address address;
  Customer customer;
  dynamic totalPackingAmount;
  dynamic subTotalAmount;
  dynamic deliveryTip;
  Branch branch;
  dynamic totalAmount;
  dynamic vendorTotalAmount;
  dynamic vendorCommissionTotal;
  double deliveryDistanceKm;
  dynamic deliveryDistance;
  String orderId;
  String createdAt;
  String updatedAt;
  dynamic v;
  String deliveryBoy;

  factory SingleOrderModel.fromJson(Map<String, dynamic> json) =>
      SingleOrderModel(
        commissionDetail: json["commissionDetail"] == null
            ? null
            : CommissionDetail.fromJson(json["commissionDetail"]),
        orderNote: json["orderNote"] == null
            ? null
            : List<dynamic>.from(json["orderNote"].map((x) => x)),
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        status: json["status"] == null
            ? null
            : List<Status>.from(json["status"].map((x) => Status.fromJson(x))),
        track: json["track"] == null
            ? null
            : List<Track>.from(json["track"].map((x) => Track.fromJson(x))),
        id: json["_id"] == null ? null : json["_id"],
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        vendorType: json["vendorType"] == null ? null : json["vendorType"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        contactNumber:
            json["contactNumber"] == null ? null : json["contactNumber"],
        deliveryCharge:
            json["deliveryCharge"] == null ? null : json["deliveryCharge"],
        discount: json["discount"] == null ? null : json["discount"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        totalPackingAmount: json["totalPackingAmount"] == null
            ? null
            : json["totalPackingAmount"],
        subTotalAmount:
            json["subTotalAmount"] == null ? null : json["subTotalAmount"],
        deliveryTip: json["deliveryTip"] == null ? null : json["deliveryTip"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        vendorTotalAmount: json["vendorTotalAmount"] == null
            ? null
            : json["vendorTotalAmount"],
        vendorCommissionTotal: json["vendorCommissionTotal"] == null
            ? null
            : json["vendorCommissionTotal"],
        deliveryDistanceKm: json["deliveryDistanceKm"] == null
            ? null
            : json["deliveryDistanceKm"].toDouble(),
        deliveryDistance:
            json["deliveryDistance"] == null ? null : json["deliveryDistance"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        deliveryBoy: json["deliveryBoy"] == null ? null : json["deliveryBoy"],
      );

  Map<String, dynamic> toJson() => {
        "commissionDetail":
            commissionDetail == null ? null : commissionDetail.toJson(),
        "orderNote": orderNote == null
            ? null
            : List<dynamic>.from(orderNote.map((x) => x)),
        "orderStatus": orderStatus == null ? null : orderStatus,
        "status": status == null
            ? null
            : List<dynamic>.from(status.map((x) => x.toJson())),
        "track": track == null
            ? null
            : List<dynamic>.from(track.map((x) => x.toJson())),
        "_id": id == null ? null : id,
        "vendor": vendor == null ? null : vendor.toJson(),
        "vendorType": vendorType == null ? null : vendorType,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "contactNumber": contactNumber == null ? null : contactNumber,
        "deliveryCharge": deliveryCharge == null ? null : deliveryCharge,
        "discount": discount == null ? null : discount,
        "paymentType": paymentType == null ? null : paymentType,
        "address": address == null ? null : address.toJson(),
        "customer": customer == null ? null : customer.toJson(),
        "totalPackingAmount":
            totalPackingAmount == null ? null : totalPackingAmount,
        "subTotalAmount": subTotalAmount == null ? null : subTotalAmount,
        "deliveryTip": deliveryTip == null ? null : deliveryTip,
        "branch": branch == null ? null : branch.toJson(),
        "totalAmount": totalAmount == null ? null : totalAmount,
        "vendorTotalAmount":
            vendorTotalAmount == null ? null : vendorTotalAmount,
        "vendorCommissionTotal":
            vendorCommissionTotal == null ? null : vendorCommissionTotal,
        "deliveryDistanceKm":
            deliveryDistanceKm == null ? null : deliveryDistanceKm,
        "deliveryDistance": deliveryDistance == null ? null : deliveryDistance,
        "orderId": orderId == null ? null : orderId,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
        "deliveryBoy": deliveryBoy == null ? null : deliveryBoy,
      };
}

class Address {
  Address({
    this.address,
    this.landmark,
    this.coordinates,
    this.formattedAddress,
    this.addressType,
  });

  String address;
  dynamic landmark;
  List<double> coordinates;
  String formattedAddress;
  dynamic addressType;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"] == null ? null : json["address"],
        landmark: json["landmark"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        formattedAddress:
            json["formattedAddress"] == null ? null : json["formattedAddress"],
        addressType: json["addressType"],
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "landmark": landmark,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
        "formattedAddress": formattedAddress == null ? null : formattedAddress,
        "addressType": addressType,
      };
}

class Branch {
  Branch({
    this.location,
    this.id,
    this.name,
    this.supportNumber,
  });

  BranchLocation location;
  String id;
  String name;
  dynamic supportNumber;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        location: json["location"] == null
            ? null
            : BranchLocation.fromJson(json["location"]),
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        supportNumber:
            json["supportNumber"] == null ? null : json["supportNumber"],
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location.toJson(),
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "supportNumber": supportNumber == null ? null : supportNumber,
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

class CommissionDetail {
  CommissionDetail({
    this.type,
    this.commission,
    this.commissionAmount,
  });

  String type;
  dynamic commission;
  dynamic commissionAmount;

  factory CommissionDetail.fromJson(Map<String, dynamic> json) =>
      CommissionDetail(
        type: json["type"] == null ? null : json["type"],
        commission: json["commission"] == null ? null : json["commission"],
        commissionAmount:
            json["commissionAmount"] == null ? null : json["commissionAmount"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "commission": commission == null ? null : commission,
        "commissionAmount": commissionAmount == null ? null : commissionAmount,
      };
}

class Customer {
  Customer({
    this.id,
    this.user,
    this.name,
  });

  String id;
  String user;
  String name;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : json["user"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user,
        "name": name == null ? null : name,
      };
}

class Item {
  Item({
    this.id,
    this.name,
    this.ausmartPrice,
    this.price,
    this.offerPrice,
    this.packingCharge,
    this.qty,
  });

  String id;
  String name;
  dynamic ausmartPrice;
  dynamic price;
  dynamic offerPrice;
  dynamic packingCharge;
  dynamic qty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        ausmartPrice:
            json["ausmartPrice"] == null ? null : json["ausmartPrice"],
        price: json["price"] == null ? null : json["price"],
        offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
        packingCharge:
            json["packingCharge"] == null ? null : json["packingCharge"],
        qty: json["qty"] == null ? null : json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "price": price == null ? null : price,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "packingCharge": packingCharge == null ? null : packingCharge,
        "qty": qty == null ? null : qty,
      };
}

class Status {
  Status({
    this.info,
    this.updated,
    this.updatedBy,
  });

  String info;
  String updated;
  String updatedBy;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        info: json["info"] == null ? null : json["info"],
        updated: json["updated"] == null ? null : json["updated"],
        updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "info": info == null ? null : info,
        "updated": updated == null ? null : updated,
        "updatedBy": updatedBy == null ? null : updatedBy,
      };
}

class Track {
  Track({
    this.info,
    this.code,
    this.detail,
    this.asset,
    this.status,
    this.updated,
  });

  String info;
  String code;
  String detail;
  String asset;
  bool status;
  String updated;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        info: json["info"] == null ? null : json["info"],
        code: json["code"] == null ? null : json["code"],
        detail: json["detail"] == null ? null : json["detail"],
        asset: json["asset"] == null ? null : json["asset"],
        status: json["status"] == null ? null : json["status"],
        updated: json["updated"] == null ? null : json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "info": info == null ? null : info,
        "code": code == null ? null : code,
        "detail": detail == null ? null : detail,
        "asset": asset == null ? null : asset,
        "status": status == null ? null : status,
        "updated": updated == null ? null : updated,
      };
}

class Vendor {
  Vendor({
    this.location,
    this.contactNumber,
    this.id,
    this.name,
  });

  VendorLocation location;
  dynamic contactNumber;
  String id;
  String name;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        location: json["location"] == null
            ? null
            : VendorLocation.fromJson(json["location"]),
        contactNumber:
            json["contactNumber"] == null ? null : json["contactNumber"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location.toJson(),
        "contactNumber": contactNumber == null ? null : contactNumber,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class VendorLocation {
  VendorLocation({
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

  factory VendorLocation.fromJson(Map<String, dynamic> json) => VendorLocation(
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
