import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/app/models/location_lat_lng.dart';
import 'package:driver/app/models/positions_model.dart';

class DriverUserModel {
  String? fullName;
  String? slug;
  String? id;
  String? email;
  String? loginType;
  String? profilePic;
  String? dateOfBirth;
  String? fcmToken;
  String? countryCode;
  String? phoneNumber;
  String? walletAmount;
  String? totalEarning;
  String? gender;
  bool? isActive;
  bool? isVerified;
  bool? isOnline;
  Timestamp? createdAt;
  DriverVehicleDetails? driverVehicleDetails;
  LocationLatLng? location;
  Positions? position;
  dynamic rotation;
  String? reviewsCount;
  String? reviewsSum;

  DriverUserModel({
    this.fullName,
    this.slug,
    this.driverVehicleDetails,
    this.location,
    this.position,
    this.id,
    this.isActive,
    this.isVerified,
    this.isOnline,
    this.dateOfBirth,
    this.email,
    this.loginType,
    this.profilePic,
    this.fcmToken,
    this.countryCode,
    this.phoneNumber,
    this.walletAmount,
    this.totalEarning,
    this.createdAt,
    this.rotation,
    this.gender,
    this.reviewsCount,
    this.reviewsSum,
  });

  factory DriverUserModel.fromJson(Map<String, dynamic> json) => DriverUserModel(
    fullName: json['fullName'],
    slug: json['slug'],
    id: json['id'],
    email: json['email'],
    loginType: json['loginType'],
    profilePic: json['profilePic'],
    fcmToken: json['fcmToken'],
    countryCode: json['countryCode'],
    phoneNumber: json['phoneNumber'],
    walletAmount: json['walletAmount'] ?? "0",
    totalEarning: json['totalEarning'] ?? "0",
    createdAt: json['createdAt'] != null ? Timestamp.fromDate(DateTime.parse(json['createdAt'])) : null,
    gender: json['gender'],
    dateOfBirth: json['dateOfBirth'] ?? '',
    isActive: json['isActive'] ?? false,
    isOnline: json['isOnline'] ?? false,
    driverVehicleDetails: json['driverVehicleDetails'] != null
        ? DriverVehicleDetails.fromJson(json["driverVehicleDetails"])
        : null,
    isVerified: json['isVerified'] ?? false,
    location: json['location'] != null
        ? LocationLatLng.fromJson(json['location'])
        : LocationLatLng(),
    position: json['position'] != null
        ? Positions.fromJson(json['position'])
        : Positions(),
    rotation: json['rotation'],
    reviewsCount: json['reviewsCount'],
    reviewsSum: json['reviewsSum'],
  );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'slug': slug,
    'id': id,
    'email': email,
    'loginType': loginType,
    'profilePic': profilePic,
    'fcmToken': fcmToken,
    'countryCode': countryCode,
    'phoneNumber': phoneNumber,
    'walletAmount': walletAmount ?? '0.0',
    'totalEarning': totalEarning ?? '0.0',
    'createdAt': createdAt?.toDate().toString(),
    'gender': gender,
    'dateOfBirth': dateOfBirth,
    'isActive': isActive ?? false,
    'isOnline': isOnline ?? false,
    'isVerified': isVerified ?? false,
    'driverVehicleDetails': driverVehicleDetails?.toJson(),
    'location': location?.toJson(),
    'position': position?.toJson(),
    'rotation': rotation,
    'reviewsCount': reviewsCount ?? '0',
    'reviewsSum': reviewsSum ?? "0.0",
  };
}

class DriverVehicleDetails {
  String? vehicleTypeName;
  String? vehicleTypeId;
  String? brandName;
  String? brandId;
  String? modelName;
  String? modelId;
  String? vehicleNumber;
  bool? isVerified;

    DriverVehicleDetails({
    this.vehicleTypeName,
    this.vehicleTypeId,
    this.brandName,
    this.brandId,
    this.modelName,
    this.modelId,
    this.vehicleNumber,
    this.isVerified,
  });

  factory DriverVehicleDetails.fromRawJson(String str) =>
      DriverVehicleDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriverVehicleDetails.fromJson(Map<String, dynamic> json) =>
      DriverVehicleDetails(
        vehicleTypeName: json["vehicleTypeName"],
        vehicleTypeId: json["vehicleTypeId"],
        brandName: json["brandName"],
        brandId: json["brandId"],
        modelName: json["modelName"],
        modelId: json["modelId"],
        vehicleNumber: json["vehicleNumber"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "vehicleTypeName": vehicleTypeName ?? '',
        "vehicleTypeId": vehicleTypeId ?? '',
        "brandName": brandName ?? '',
        "brandId": brandId ?? '',
        "modelName": modelName ?? '',
        "modelId": modelId ?? '',
        "vehicleNumber": vehicleNumber ?? '',
        "isVerified": isVerified ?? false,
      };
}
