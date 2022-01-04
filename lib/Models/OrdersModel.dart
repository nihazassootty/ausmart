// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrdersModel ordersModelFromJson(String str) => OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
    OrdersModel({
        @required this.data,
    });

    final List<Datum> data;

    factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        @required this.commissionDetail,
        @required this.orderType,
        @required this.orderNote,
        @required this.orderStatus,
        @required this.track,
        @required this.id,
        @required this.vendor,
        @required this.vendorType,
        @required this.items,
        @required this.paymentType,
        @required this.address,
        @required this.customer,
        @required this.totalPackingAmount,
        @required this.subTotalAmount,
        @required this.branch,
        @required this.totalAmount,
        @required this.vendorTotalAmount,
        @required this.vendorCommissionTotal,
        @required this.orderId,
        @required this.createdAt,
        @required this.updatedAt,
        @required this.v,
        @required this.deliveryBoy,
    });

    final CommissionDetail commissionDetail;
    final String orderType;
    final List<dynamic> orderNote;
    final String orderStatus;
    final List<Track> track;
    final String id;
    final Vendor vendor;
    final String vendorType;
    final List<Item> items;
    final String paymentType;
    final Address address;
    final String customer;
    final dynamic totalPackingAmount;
    final dynamic subTotalAmount;
    final String branch;
    final double totalAmount;
    final dynamic vendorTotalAmount;
    final dynamic vendorCommissionTotal;
    final String orderId;
    final String createdAt;
    final String updatedAt;
    final dynamic v;
    final String deliveryBoy;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        commissionDetail: json["commissionDetail"] == null ? null : CommissionDetail.fromJson(json["commissionDetail"]),
        orderType: json["orderType"] == null ? null : json["orderType"],
        orderNote: json["orderNote"] == null ? null : List<dynamic>.from(json["orderNote"].map((x) => x)),
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        track: json["track"] == null ? null : List<Track>.from(json["track"].map((x) => Track.fromJson(x))),
        id: json["_id"] == null ? null : json["_id"],
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        vendorType: json["vendorType"] == null ? null : json["vendorType"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        customer: json["customer"] == null ? null : json["customer"],
        totalPackingAmount: json["totalPackingAmount"] == null ? null : json["totalPackingAmount"],
        subTotalAmount: json["subTotalAmount"] == null ? null : json["subTotalAmount"],
        branch: json["branch"] == null ? null : json["branch"],
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"].toDouble(),
        vendorTotalAmount: json["vendorTotalAmount"] == null ? null : json["vendorTotalAmount"],
        vendorCommissionTotal: json["vendorCommissionTotal"] == null ? null : json["vendorCommissionTotal"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        deliveryBoy: json["deliveryBoy"] == null ? null : json["deliveryBoy"],
    );

    Map<String, dynamic> toJson() => {
        "commissionDetail": commissionDetail == null ? null : commissionDetail.toJson(),
        "orderType": orderType == null ? null : orderType,
        "orderNote": orderNote == null ? null : List<dynamic>.from(orderNote.map((x) => x)),
        "orderStatus": orderStatus == null ? null : orderStatus,
        "track": track == null ? null : List<dynamic>.from(track.map((x) => x.toJson())),
        "_id": id == null ? null : id,
        "vendor": vendor == null ? null : vendor.toJson(),
        "vendorType": vendorType == null ? null : vendorType,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
        "paymentType": paymentType == null ? null : paymentType,
        "address": address == null ? null : address.toJson(),
        "customer": customer == null ? null : customer,
        "totalPackingAmount": totalPackingAmount == null ? null : totalPackingAmount,
        "subTotalAmount": subTotalAmount == null ? null : subTotalAmount,
        "branch": branch == null ? null : branch,
        "totalAmount": totalAmount == null ? null : totalAmount,
        "vendorTotalAmount": vendorTotalAmount == null ? null : vendorTotalAmount,
        "vendorCommissionTotal": vendorCommissionTotal == null ? null : vendorCommissionTotal,
        "orderId": orderId == null ? null : orderId,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
        "deliveryBoy": deliveryBoy == null ? null : deliveryBoy,
    };
}

class Address {
    Address({
        @required this.address,
        @required this.landmark,
        @required this.coordinates,
        @required this.formattedAddress,
        @required this.addressType,
        @required this.type,
    });

    final String address;
    final String landmark;
    final List<double> coordinates;
    final String formattedAddress;
    final String addressType;
    final String type;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"] == null ? null : json["address"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        coordinates: json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        formattedAddress: json["formattedAddress"] == null ? null : json["formattedAddress"],
        addressType: json["addressType"] == null ? null : json["addressType"],
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "landmark": landmark == null ? null : landmark,
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
        "formattedAddress": formattedAddress == null ? null : formattedAddress,
        "addressType": addressType == null ? null : addressType,
        "type": type == null ? null : type,
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

class Item {
    Item({
        @required this.id,
        @required this.name,
        @required this.ausmartPrice,
        @required this.price,
        @required this.offerPrice,
        @required this.packingCharge,
        @required this.qty,
        @required this.type,
    });

    final String id;
    final String name;
    final dynamic ausmartPrice;
    final dynamic price;
    final dynamic offerPrice;
    final dynamic packingCharge;
    final dynamic qty;
    final String type;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        ausmartPrice: json["ausmartPrice"] == null ? null : json["ausmartPrice"],
        price: json["price"] == null ? null : json["price"],
        offerPrice: json["offerPrice"],
        packingCharge: json["packingCharge"],
        qty: json["qty"] == null ? null : json["qty"],
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "price": price == null ? null : price,
        "offerPrice": offerPrice,
        "packingCharge": packingCharge,
        "qty": qty == null ? null : qty,
        "type": type == null ? null : type,
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

class Vendor {
    Vendor({
        @required this.storeBg,
        @required this.location,
        @required this.id,
        @required this.name,
    });

    final StoreBg storeBg;
    final Address location;
    final String id;
    final String name;

    factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        storeBg: json["storeBg"] == null ? null : StoreBg.fromJson(json["storeBg"]),
        location: json["location"] == null ? null : Address.fromJson(json["location"]),
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "storeBg": storeBg == null ? null : storeBg.toJson(),
        "location": location == null ? null : location.toJson(),
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
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
