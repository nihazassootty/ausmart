// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  OrdersModel({
    this.data,
  });

  List<Datum> data;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.commissionDetail,
    this.orderType,
    this.orderNote,
    this.orderStatus,
    this.id,
    this.customer,
    this.totalPackingAmount,
    this.subTotalAmount,
    this.branch,
    this.totalAmount,
    this.vendorTotalAmount,
    this.vendorCommissionTotal,
    this.vendor,
    this.vendorType,
    this.items,
    this.paymentType,
    this.address,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  CommissionDetail commissionDetail;
  String orderType;
  List<dynamic> orderNote;
  String orderStatus;
  String id;
  String customer;
  int totalPackingAmount;
  int subTotalAmount;
  String branch;
  int totalAmount;
  int vendorTotalAmount;
  double vendorCommissionTotal;
  String vendor;
  String vendorType;
  List<Item> items;
  String paymentType;
  Address address;
  String orderId;
  String createdAt;
  String updatedAt;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        commissionDetail: json["commissionDetail"] == null
            ? null
            : CommissionDetail.fromJson(json["commissionDetail"]),
        orderType: json["orderType"] == null ? null : json["orderType"],
        orderNote: json["orderNote"] == null
            ? null
            : List<dynamic>.from(json["orderNote"].map((x) => x)),
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        id: json["_id"] == null ? null : json["_id"],
        customer: json["customer"] == null ? null : json["customer"],
        totalPackingAmount: json["totalPackingAmount"] == null
            ? null
            : json["totalPackingAmount"],
        subTotalAmount:
            json["subTotalAmount"] == null ? null : json["subTotalAmount"],
        branch: json["branch"] == null ? null : json["branch"],
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        vendorTotalAmount: json["vendorTotalAmount"] == null
            ? null
            : json["vendorTotalAmount"],
        vendorCommissionTotal: json["vendorCommissionTotal"] == null
            ? null
            : json["vendorCommissionTotal"].toDouble(),
        vendor: json["vendor"] == null ? null : json["vendor"],
        vendorType: json["vendorType"] == null ? null : json["vendorType"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        orderId: json["orderId"] == null ? null : json["orderId"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "commissionDetail":
            commissionDetail == null ? null : commissionDetail.toJson(),
        "orderType": orderType == null ? null : orderType,
        "orderNote": orderNote == null
            ? null
            : List<dynamic>.from(orderNote.map((x) => x)),
        "orderStatus": orderStatus == null ? null : orderStatus,
        "_id": id == null ? null : id,
        "customer": customer == null ? null : customer,
        "totalPackingAmount":
            totalPackingAmount == null ? null : totalPackingAmount,
        "subTotalAmount": subTotalAmount == null ? null : subTotalAmount,
        "branch": branch == null ? null : branch,
        "totalAmount": totalAmount == null ? null : totalAmount,
        "vendorTotalAmount":
            vendorTotalAmount == null ? null : vendorTotalAmount,
        "vendorCommissionTotal":
            vendorCommissionTotal == null ? null : vendorCommissionTotal,
        "vendor": vendor == null ? null : vendor,
        "vendorType": vendorType == null ? null : vendorType,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "paymentType": paymentType == null ? null : paymentType,
        "address": address == null ? null : address.toJson(),
        "orderId": orderId == null ? null : orderId,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
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

class CommissionDetail {
  CommissionDetail({
    this.type,
    this.commission,
    this.commissionAmount,
  });

  String type;
  int commission;
  double commissionAmount;

  factory CommissionDetail.fromJson(Map<String, dynamic> json) =>
      CommissionDetail(
        type: json["type"] == null ? null : json["type"],
        commission: json["commission"] == null ? null : json["commission"],
        commissionAmount: json["commissionAmount"] == null
            ? null
            : json["commissionAmount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "commission": commission == null ? null : commission,
        "commissionAmount": commissionAmount == null ? null : commissionAmount,
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
  int ausmartPrice;
  int price;
  int offerPrice;
  dynamic packingCharge;
  int qty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        ausmartPrice:
            json["ausmartPrice"] == null ? null : json["ausmartPrice"],
        price: json["price"] == null ? null : json["price"],
        offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
        packingCharge: json["packingCharge"],
        qty: json["qty"] == null ? null : json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "ausmartPrice": ausmartPrice == null ? null : ausmartPrice,
        "price": price == null ? null : price,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "packingCharge": packingCharge,
        "qty": qty == null ? null : qty,
      };
}
