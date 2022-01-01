// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    this.customer,
  });

  Customer customer;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "customer": customer == null ? null : customer.toJson(),
      };
}

class Customer {
  Customer({
    this.verification,
    this.pending,
    this.debit,
    this.id,
    this.user,
    this.name,
    this.email,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.recentBranch,
    this.fcmToken,
    this.block,
    this.dueAmount,
    this.blockedReason,
  });

  bool verification;
  int pending;
  int debit;
  String id;
  User user;
  String name;
  String email;
  List<dynamic> address;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String recentBranch;
  String fcmToken;
  bool block;
  dynamic dueAmount;
  String blockedReason;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        verification:
            json["verification"] == null ? null : json["verification"],
        pending: json["pending"] == null ? null : json["pending"],
        debit: json["debit"] == null ? null : json["debit"],
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        recentBranch:
            json["recentBranch"] == null ? null : json["recentBranch"],
        fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
        block: json["block"] == null ? null : json["block"],
        dueAmount: json["dueAmount"] == null ? null : json["dueAmount"],
      );

  Map<String, dynamic> toJson() => {
        "verification": verification == null ? null : verification,
        "pending": pending == null ? null : pending,
        "debit": debit == null ? null : debit,
        "_id": id == null ? null : id,
        "user": user == null ? null : user.toJson(),
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "recentBranch": recentBranch == null ? null : recentBranch,
        "fcmToken": fcmToken == null ? null : fcmToken,
        "block": block == null ? null : block,
        "dueAmount": dueAmount == null ? null : dueAmount,
      };
}

class Address {
  Address({
    this.type,
    this.coordinates,
    this.id,
    this.address,
    this.landmark,
    this.formattedAddress,
    this.addressType,
  });

  String type;
  List<double> coordinates;
  String id;
  String address;
  String landmark;
  String formattedAddress;
  String addressType;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        id: json["_id"] == null ? null : json["_id"],
        address: json["address"] == null ? null : json["address"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        formattedAddress:
            json["formattedAddress"] == null ? null : json["formattedAddress"],
        addressType: json["addressType"] == null ? null : json["addressType"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
        "_id": id == null ? null : id,
        "address": address == null ? null : address,
        "landmark": landmark == null ? null : landmark,
        "formattedAddress": formattedAddress == null ? null : formattedAddress,
        "addressType": addressType == null ? null : addressType,
      };
}

class User {
  User({
    this.id,
    this.username,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String username;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        username: json["username"] == null ? null : json["username"],
        role: json["role"] == null ? null : json["role"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "username": username == null ? null : username,
        "role": role == null ? null : role,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
