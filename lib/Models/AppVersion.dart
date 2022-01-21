// To parse this JSON data, do
//
//     final appVersion = appVersionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AppVersion appVersionFromJson(String str) => AppVersion.fromJson(json.decode(str));

String appVersionToJson(AppVersion data) => json.encode(data.toJson());

class AppVersion {
    AppVersion({
        @required this.success,
        @required this.data,
    });

    final bool success;
    final Data data;

    factory AppVersion.fromJson(Map<String, dynamic> json) => AppVersion(
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
        @required this.appStatus,
        @required this.id,
        @required this.v,
        @required this.createdAt,
        @required this.updatedAt,
        @required this.application,
    });

    final bool appStatus;
    final String id;
    final dynamic v;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Application application;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        appStatus: json["appStatus"] == null ? null : json["appStatus"],
        id: json["_id"] == null ? null : json["_id"],
        v: json["__v"] == null ? null : json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        application: json["application"] == null ? null : Application.fromJson(json["application"]),
    );

    Map<String, dynamic> toJson() => {
        "appStatus": appStatus == null ? null : appStatus,
        "_id": id == null ? null : id,
        "__v": v == null ? null : v,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "application": application == null ? null : application.toJson(),
    };
}

class Application {
    Application({
        @required this.customer,
        @required this.vendor,
        @required this.delivery,
    });

    final Customer customer;
    final Customer vendor;
    final Customer delivery;

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        vendor: json["vendor"] == null ? null : Customer.fromJson(json["vendor"]),
        delivery: json["delivery"] == null ? null : Customer.fromJson(json["delivery"]),
    );

    Map<String, dynamic> toJson() => {
        "customer": customer == null ? null : customer.toJson(),
        "vendor": vendor == null ? null : vendor.toJson(),
        "delivery": delivery == null ? null : delivery.toJson(),
    };
}

class Customer {
    Customer({
        @required this.android,
        @required this.ios,
    });

    final Android android;
    final Android ios;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        android: json["android"] == null ? null : Android.fromJson(json["android"]),
        ios: json["ios"] == null ? null : Android.fromJson(json["ios"]),
    );

    Map<String, dynamic> toJson() => {
        "android": android == null ? null : android.toJson(),
        "ios": ios == null ? null : ios.toJson(),
    };
}

class Android {
    Android({
        @required this.version,
        @required this.force,
        @required this.updateMessage,
        @required this.applink,
        @required this.updateDate,
    });

    final dynamic version;
    final bool force;
    final String updateMessage;
    final String applink;
    final DateTime updateDate;

    factory Android.fromJson(Map<String, dynamic> json) => Android(
        version: json["version"] == null ? null : json["version"],
        force: json["force"] == null ? null : json["force"],
        updateMessage: json["updateMessage"] == null ? null : json["updateMessage"],
        applink: json["applink"] == null ? null : json["applink"],
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
    );

    Map<String, dynamic> toJson() => {
        "version": version == null ? null : version,
        "force": force == null ? null : force,
        "updateMessage": updateMessage == null ? null : updateMessage,
        "applink": applink == null ? null : applink,
        "updateDate": updateDate == null ? null : updateDate.toIso8601String(),
    };
}
