// To parse this JSON data, do
//
//     final singleOrderModel = singleOrderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SingleOrderModel singleOrderModelFromJson(String str) => SingleOrderModel.fromJson(json.decode(str));

String singleOrderModelToJson(SingleOrderModel data) => json.encode(data.toJson());

class SingleOrderModel {
    SingleOrderModel({
        @required this.success,
        @required this.data,
    });

    final bool success;
    final Data data;

    factory SingleOrderModel.fromJson(Map<String, dynamic> json) => SingleOrderModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        @required this.commissionDetail,
        @required this.orderType,
        @required this.orderNote,
        @required this.orderStatus,
        @required this.status,
        @required this.track,
        @required this.id,
        @required this.vendor,
        @required this.vendorType,
        @required this.items,
        @required this.contactNumber,
        @required this.deliveryCharge,
        @required this.paymentType,
        @required this.address,
        @required this.customer,
        @required this.totalPackingAmount,
        @required this.subTotalAmount,
        @required this.branch,
        @required this.totalAmount,
        @required this.vendorTotalAmount,
        @required this.vendorCommissionTotal,
        @required this.deliveryDistanceKm,
        @required this.deliveryDistance,
        @required this.orderId,
        @required this.expense,
        @required this.createdAt,
        @required this.updatedAt,
        @required this.v,
    });

    final CommissionDetail commissionDetail;
    final String orderType;
    final List<dynamic> orderNote;
    final String orderStatus;
    final List<Status> status;
    final List<Track> track;
    final String id;
    final String vendor;
    final String vendorType;
    final List<Item> items;
    final String contactNumber;
    final double deliveryCharge;
    final String paymentType;
    final Address address;
    final Customer customer;
    final dynamic totalPackingAmount;
    final dynamic subTotalAmount;
    final Branch branch;
    final double totalAmount;
    final dynamic vendorTotalAmount;
    final dynamic vendorCommissionTotal;
    final double deliveryDistanceKm;
    final dynamic deliveryDistance;
    final String orderId;
    final List<dynamic> expense;
    final String createdAt;
    final String updatedAt;
    final dynamic v;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        commissionDetail: json["commissionDetail"] == null ? null : CommissionDetail.fromJson(json["commissionDetail"]),
        orderType: json["orderType"] == null ? null : json["orderType"],
        orderNote: json["orderNote"] == null ? null : List<dynamic>.from(json["orderNote"].map((x) => x)),
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        status: json["status"] == null ? null : List<Status>.from(json["status"].map((x) => Status.fromJson(x))),
        track: json["track"] == null ? null : List<Track>.from(json["track"].map((x) => Track.fromJson(x))),
        id: json["_id"] == null ? null : json["_id"],
        vendor: json["vendor"] == null ? null : json["vendor"],
        vendorType: json["vendorType"] == null ? null : json["vendorType"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
        deliveryCharge: json["deliveryCharge"] == null ? null : json["deliveryCharge"].toDouble(),
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        totalPackingAmount: json["totalPackingAmount"] == null ? null : json["totalPackingAmount"],
        subTotalAmount: json["subTotalAmount"] == null ? null : json["subTotalAmount"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"].toDouble(),
        vendorTotalAmount: json["vendorTotalAmount"] == null ? null : json["vendorTotalAmount"],
        vendorCommissionTotal: json["vendorCommissionTotal"] == null ? null : json["vendorCommissionTotal"],
        deliveryDistanceKm: json["deliveryDistanceKm"] == null ? null : json["deliveryDistanceKm"].toDouble(),
        deliveryDistance: json["deliveryDistance"] == null ? null : json["deliveryDistance"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        expense: json["expense"] == null ? null : List<dynamic>.from(json["expense"].map((x) => x)),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "commissionDetail": commissionDetail == null ? null : commissionDetail.toJson(),
        "orderType": orderType == null ? null : orderType,
        "orderNote": orderNote == null ? null : List<dynamic>.from(orderNote.map((x) => x)),
        "orderStatus": orderStatus == null ? null : orderStatus,
        "status": status == null ? null : List<dynamic>.from(status.map((x) => x.toJson())),
        "track": track == null ? null : List<dynamic>.from(track.map((x) => x.toJson())),
        "_id": id == null ? null : id,
        "vendor": vendor == null ? null : vendor,
        "vendorType": vendorType == null ? null : vendorType,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
        "contactNumber": contactNumber == null ? null : contactNumber,
        "deliveryCharge": deliveryCharge == null ? null : deliveryCharge,
        "paymentType": paymentType == null ? null : paymentType,
        "address": address == null ? null : address.toJson(),
        "customer": customer == null ? null : customer.toJson(),
        "totalPackingAmount": totalPackingAmount == null ? null : totalPackingAmount,
        "subTotalAmount": subTotalAmount == null ? null : subTotalAmount,
        "branch": branch == null ? null : branch.toJson(),
        "totalAmount": totalAmount == null ? null : totalAmount,
        "vendorTotalAmount": vendorTotalAmount == null ? null : vendorTotalAmount,
        "vendorCommissionTotal": vendorCommissionTotal == null ? null : vendorCommissionTotal,
        "deliveryDistanceKm": deliveryDistanceKm == null ? null : deliveryDistanceKm,
        "deliveryDistance": deliveryDistance == null ? null : deliveryDistance,
        "orderId": orderId == null ? null : orderId,
        "expense": expense == null ? null : List<dynamic>.from(expense.map((x) => x)),
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
    };
}

class Address {
    Address({
        @required this.address,
        @required this.landmark,
        @required this.coordinates,
        @required this.formattedAddress,
        @required this.addressType,
    });

    final String address;
    final dynamic landmark;
    final List<double> coordinates;
    final String formattedAddress;
    final dynamic addressType;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"] == null ? null : json["address"],
        landmark: json["landmark"],
        coordinates: json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        formattedAddress: json["formattedAddress"] == null ? null : json["formattedAddress"],
        addressType: json["addressType"],
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "landmark": landmark,
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
        "formattedAddress": formattedAddress == null ? null : formattedAddress,
        "addressType": addressType,
    };
}

class Branch {
    Branch({
        @required this.location,
        @required this.id,
        @required this.name,
        @required this.supportNumber,
    });

    final Location location;
    final String id;
    final String name;
    final dynamic supportNumber;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        supportNumber: json["supportNumber"] == null ? null : json["supportNumber"],
    );

    Map<String, dynamic> toJson() => {
        "location": location == null ? null : location.toJson(),
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "supportNumber": supportNumber == null ? null : supportNumber,
    };
}

class Location {
    Location({
        @required this.type,
        @required this.coordinates,
        @required this.address,
    });

    final String type;
    final List<double> coordinates;
    final String address;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
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

class CommissionDetail {
    CommissionDetail({
        @required this.type,
        @required this.commission,
        @required this.commissionAmount,
    });

    final String type;
    final dynamic commission;
    final dynamic commissionAmount;

    factory CommissionDetail.fromJson(Map<String, dynamic> json) => CommissionDetail(
        type: json["type"] == null ? null : json["type"],
        commission: json["commission"] == null ? null : json["commission"],
        commissionAmount: json["commissionAmount"] == null ? null : json["commissionAmount"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "commission": commission == null ? null : commission,
        "commissionAmount": commissionAmount == null ? null : commissionAmount,
    };
}

class Customer {
    Customer({
        @required this.id,
        @required this.user,
        @required this.name,
    });

    final String id;
    final String user;
    final String name;

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
        @required this.id,
        @required this.name,
        @required this.ausmartPrice,
        @required this.price,
        @required this.offerPrice,
        @required this.packingCharge,
        @required this.qty,
    });

    final String id;
    final String name;
    final dynamic ausmartPrice;
    final dynamic price;
    final dynamic offerPrice;
    final dynamic packingCharge;
    final dynamic qty;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        ausmartPrice: json["ausmartPrice"] == null ? null : json["ausmartPrice"],
        price: json["price"] == null ? null : json["price"],
        offerPrice: json["offerPrice"],
        packingCharge: json["packingCharge"],
        qty: json["qty"] == null ? null : json["qty"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "price": price == null ? null : price,
        "offerPrice": offerPrice,
        "packingCharge": packingCharge,
        "qty": qty == null ? null : qty,
    };
}

class Status {
    Status({
        @required this.info,
        @required this.updated,
    });

    final String info;
    final String updated;

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        info: json["info"] == null ? null : json["info"],
        updated: json["updated"] == null ? null : json["updated"],
    );

    Map<String, dynamic> toJson() => {
        "info": info == null ? null : info,
        "updated": updated == null ? null : updated,
    };
}

class Track {
    Track({
        @required this.info,
        @required this.code,
        @required this.detail,
        @required this.asset,
        @required this.status,
        @required this.updated,
    });

    final String info;
    final String code;
    final String detail;
    final String asset;
    final bool status;
    final String updated;

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
