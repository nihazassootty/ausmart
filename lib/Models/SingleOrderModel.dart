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
        @required this.id,
        @required this.customer,
        @required this.deliveryCharge,
        @required this.totalPackingAmount,
        @required this.subTotalAmount,
        @required this.branch,
        @required this.totalAmount,
        @required this.vendorTotalAmount,
        @required this.vendorCommissionTotal,
        @required this.deliveryDistanceKm,
        @required this.deliveryDistance,
        @required this.vendor,
        @required this.vendorType,
        @required this.items,
        @required this.contactNumber,
        @required this.paymentType,
        @required this.address,
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
    final String id;
    final Customer customer;
    final dynamic deliveryCharge;
    final dynamic totalPackingAmount;
    final dynamic subTotalAmount;
    final Branch branch;
    final dynamic totalAmount;
    final dynamic vendorTotalAmount;
    final double vendorCommissionTotal;
    final double deliveryDistanceKm;
    final dynamic deliveryDistance;
    final String vendor;
    final String vendorType;
    final List<Item> items;
    final String contactNumber;
    final String paymentType;
    final Address address;
    final String orderId;
    final List<dynamic> expense;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic v;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        commissionDetail: json["commissionDetail"] == null ? null : CommissionDetail.fromJson(json["commissionDetail"]),
        orderType: json["orderType"] == null ? null : json["orderType"],
        orderNote: json["orderNote"] == null ? null : List<dynamic>.from(json["orderNote"].map((x) => x)),
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        status: json["status"] == null ? null : List<Status>.from(json["status"].map((x) => Status.fromJson(x))),
        id: json["_id"] == null ? null : json["_id"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        deliveryCharge: json["deliveryCharge"] == null ? null : json["deliveryCharge"],
        totalPackingAmount: json["totalPackingAmount"] == null ? null : json["totalPackingAmount"],
        subTotalAmount: json["subTotalAmount"] == null ? null : json["subTotalAmount"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        vendorTotalAmount: json["vendorTotalAmount"] == null ? null : json["vendorTotalAmount"],
        vendorCommissionTotal: json["vendorCommissionTotal"] == null ? null : json["vendorCommissionTotal"].toDouble(),
        deliveryDistanceKm: json["deliveryDistanceKm"] == null ? null : json["deliveryDistanceKm"].toDouble(),
        deliveryDistance: json["deliveryDistance"] == null ? null : json["deliveryDistance"],
        vendor: json["vendor"] == null ? null : json["vendor"],
        vendorType: json["vendorType"] == null ? null : json["vendorType"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        orderId: json["orderId"] == null ? null : json["orderId"],
        expense: json["expense"] == null ? null : List<dynamic>.from(json["expense"].map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "commissionDetail": commissionDetail == null ? null : commissionDetail.toJson(),
        "orderType": orderType == null ? null : orderType,
        "orderNote": orderNote == null ? null : List<dynamic>.from(orderNote.map((x) => x)),
        "orderStatus": orderStatus == null ? null : orderStatus,
        "status": status == null ? null : List<dynamic>.from(status.map((x) => x.toJson())),
        "_id": id == null ? null : id,
        "customer": customer == null ? null : customer.toJson(),
        "deliveryCharge": deliveryCharge == null ? null : deliveryCharge,
        "totalPackingAmount": totalPackingAmount == null ? null : totalPackingAmount,
        "subTotalAmount": subTotalAmount == null ? null : subTotalAmount,
        "branch": branch == null ? null : branch.toJson(),
        "totalAmount": totalAmount == null ? null : totalAmount,
        "vendorTotalAmount": vendorTotalAmount == null ? null : vendorTotalAmount,
        "vendorCommissionTotal": vendorCommissionTotal == null ? null : vendorCommissionTotal,
        "deliveryDistanceKm": deliveryDistanceKm == null ? null : deliveryDistanceKm,
        "deliveryDistance": deliveryDistance == null ? null : deliveryDistance,
        "vendor": vendor == null ? null : vendor,
        "vendorType": vendorType == null ? null : vendorType,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
        "contactNumber": contactNumber == null ? null : contactNumber,
        "paymentType": paymentType == null ? null : paymentType,
        "address": address == null ? null : address.toJson(),
        "orderId": orderId == null ? null : orderId,
        "expense": expense == null ? null : List<dynamic>.from(expense.map((x) => x)),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
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
    final String landmark;
    final List<double> coordinates;
    final String formattedAddress;
    final String addressType;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"] == null ? null : json["address"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        coordinates: json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        formattedAddress: json["formattedAddress"] == null ? null : json["formattedAddress"],
        addressType: json["addressType"] == null ? null : json["addressType"],
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "landmark": landmark == null ? null : landmark,
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
        "formattedAddress": formattedAddress == null ? null : formattedAddress,
        "addressType": addressType == null ? null : addressType,
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
    final double commissionAmount;

    factory CommissionDetail.fromJson(Map<String, dynamic> json) => CommissionDetail(
        type: json["type"] == null ? null : json["type"],
        commission: json["commission"] == null ? null : json["commission"],
        commissionAmount: json["commissionAmount"] == null ? null : json["commissionAmount"].toDouble(),
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
        @required this.qty,
        @required this.type,
    });

    final String id;
    final String name;
    final dynamic ausmartPrice;
    final dynamic price;
    final dynamic offerPrice;
    final dynamic qty;
    final String type;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        ausmartPrice: json["ausmartPrice"] == null ? null : json["ausmartPrice"],
        price: json["price"] == null ? null : json["price"],
        offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
        qty: json["qty"] == null ? null : json["qty"],
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "price": price == null ? null : price,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "qty": qty == null ? null : qty,
        "type": type == null ? null : type,
    };
}

class Status {
    Status({
        @required this.info,
        @required this.updated,
        @required this.updatedBy,
    });

    final String info;
    final DateTime updated;
    final String updatedBy;

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        info: json["info"] == null ? null : json["info"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    );

    Map<String, dynamic> toJson() => {
        "info": info == null ? null : info,
        "updated": updated == null ? null : updated.toIso8601String(),
        "updatedBy": updatedBy == null ? null : updatedBy,
    };
}
