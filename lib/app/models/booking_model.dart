import 'dart:convert';

class BookingModel {
  String? id; // Corresponds to _id
  String? rideId; // Corresponds to ride_id
  String? driverId; // Corresponds to driver_id
  String? notes; // Corresponds to notes
  String? status; // Corresponds to status
  String? createdAt; // Corresponds to createdAt
  String? updatedAt; // Corresponds to updatedAt
  int? version; // Corresponds to __v
  Ride? ride; // Corresponds to ride
  List<Passenger>? passengers; // Corresponds to passenger
  List<Driver>? drivers; // Corresponds to driver
  String? dropTime; // Corresponds to dropTime
  List<String>? rejectedDriverId; // Add this line
  String? cancelledBy; // Add this line

  BookingModel({
    this.id,
    this.rideId,
    this.driverId,
    this.notes,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.ride,
    this.passengers,
    this.drivers,
    this.dropTime,
    this.rejectedDriverId,
    this.cancelledBy,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["_id"],
        rideId: json["ride_id"],
        driverId: json["driver_id"],
        notes: json["notes"],
        status: json["status"],
        createdAt: json["createdAt"].toString(),
        updatedAt: json["updatedAt"].toString(),
        version: json["__v"],
        ride: json["ride"] != null ? Ride.fromJson(json["ride"]) : null,
        passengers: json["passenger"] != null
            ? List<Passenger>.from(json["passenger"].map((x) => Passenger.fromJson(x)))
            : [],
        drivers: json["driver"] != null
            ? List<Driver>.from(json["driver"].map((x) => Driver.fromJson(x)))
            : [],
        dropTime: json["dropTime"],
        rejectedDriverId: List<String>.from(json['rejectedDriverId'] ?? []), // Add this line
        cancelledBy: json["cancelledBy"], // Add this line
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ride_id": rideId,
        "driver_id": driverId,
        "notes": notes,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": version,
        "ride": ride?.toJson(),
        "passenger": passengers?.map((x) => x.toJson()).toList(),
        "driver": drivers?.map((x) => x.toJson()).toList(),
        "dropTime": dropTime,
        "rejectedDriverId": rejectedDriverId, // Add this line
        "cancelledBy": cancelledBy, // Add this line
      };
}

class Ride {
  String? id; // Corresponds to _id
  String? passengerId; // Corresponds to passenger_id
  String? driverId; // Corresponds to driver_id
  String? vehicleId; // Corresponds to vehicle_id
  String? vehicleTypeId; // Corresponds to vehicle_type_id
  Location? pickupLocation; // Corresponds to pickup_location
  String? pickupAddress; // Corresponds to pickup_address
  Location? dropoffLocation; // Corresponds to dropoff_location
  String? dropoffAddress; // Corresponds to dropoff_address
  String? distance; // Corresponds to distance
  String? fareAmount; // Corresponds to fare_amount
  double? durationInMinutes; // Corresponds to duration_in_minutes
  String? rideStatus; // Corresponds to status
  String? couponId; // Corresponds to coupon_id
  String? otp; // Corresponds to otp
  String? paymentStatus; // Corresponds to payment_status
  String? paymentMode; // Corresponds to payment_mode
  String? createdAt; // Corresponds to createdAt
  String? updatedAt; // Corresponds to updatedAt
  int? version; // Corresponds to __v

  Ride({
    this.id,
    this.passengerId,
    this.driverId,
    this.vehicleId,
    this.vehicleTypeId,
    this.pickupLocation,
    this.pickupAddress,
    this.dropoffLocation,
    this.dropoffAddress,
    this.distance,
    this.fareAmount,
    this.durationInMinutes,
    this.rideStatus,
    this.couponId,
    this.otp,
    this.paymentStatus,
    this.paymentMode,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        id: json["_id"],
        passengerId: json["passenger_id"],
        driverId: json["driver_id"],
        vehicleId: json["vehicle_id"],
        vehicleTypeId: json["vehicle_type_id"],
        pickupLocation: json["pickup_location"] != null
            ? Location.fromJson(json["pickup_location"])
            : null,
        pickupAddress: json["pickup_address"],
        dropoffLocation: json["dropoff_location"] != null
            ? Location.fromJson(json["dropoff_location"])
            : null,
        dropoffAddress: json["dropoff_address"],
        distance: json["distance"],
        fareAmount: json["fare_amount"]?["\$numberDecimal"],
        durationInMinutes: json["duration_in_minutes"],
        rideStatus: json["status"],
        couponId: json["coupon_id"],
        otp: json["otp"],
        paymentStatus: json["payment_status"],
        paymentMode: json["payment_mode"],
        createdAt: json["createdAt"].toString(),
        updatedAt: json["updatedAt"].toString(),
        version: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "passenger_id": passengerId,
        "driver_id": driverId,
        "vehicle_id": vehicleId,
        "vehicle_type_id": vehicleTypeId,
        "pickup_location": pickupLocation?.toJson(),
        "pickup_address": pickupAddress,
        "dropoff_location": dropoffLocation?.toJson(),
        "dropoff_address": dropoffAddress,
        "distance": distance,
        "fare_amount": {"\$numberDecimal": fareAmount},
        "duration_in_minutes": durationInMinutes,
        "status": rideStatus,
        "coupon_id": couponId,
        "otp": otp,
        "payment_status": paymentStatus,
        "payment_mode": paymentMode,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": version,
      };
}

class Location {
  String? type; // Corresponds to type
  List<double>? coordinates; // Corresponds to coordinates

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates,
      };
}

class Passenger {
  String? id; // Corresponds to _id
  String? name; // Corresponds to name
  String? countryCode; // Corresponds to country_code
  String? phone; // Corresponds to phone
  bool? verified; // Corresponds to verified
  String? referralCode; // Corresponds to referral_code
  String? referralCodeBy; // Corresponds to referral_code_by
  String? role; // Corresponds to role
  String? rideStatus; // Corresponds to ride_status
  List<String>? languages; // Corresponds to languages
  Location? location; // Corresponds to location
  String? createdAt; // Corresponds to createdAt
  String? updatedAt; // Corresponds to updatedAt
  String? gender; // Corresponds to gender

  Passenger({
    this.id,
    this.name,
    this.countryCode,
    this.phone,
    this.verified,
    this.referralCode,
    this.referralCodeBy,
    this.role,
    this.rideStatus,
    this.languages,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.gender,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        id: json["_id"],
        name: json["name"],
        countryCode: json["country_code"],
        phone: json["phone"],
        verified: json["verified"],
        referralCode: json["referral_code"],
        referralCodeBy: json["referral_code_by"],
        role: json["role"],
        rideStatus: json["ride_status"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        location: json["location"] != null ? Location.fromJson(json["location"]) : null,
        createdAt: json["createdAt"].toString(),
        updatedAt: json["updatedAt"].toString(),
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "country_code": countryCode,
        "phone": phone,
        "verified": verified,
        "referral_code": referralCode,
        "referral_code_by": referralCodeBy,
        "role": role,
        "ride_status": rideStatus,
        "languages": languages,
        "location": location?.toJson(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "gender": gender,
      };
}

class Driver {
  String? id; // Corresponds to _id
  String? name; // Corresponds to name
  String? countryCode; // Corresponds to country_code
  String? phone; // Corresponds to phone
  bool? verified; // Corresponds to verified
  String? referralCode; // Corresponds to referral_code
  String? referralCodeBy; // Corresponds to referral_code_by
  String? role; // Corresponds to role
  String? rideStatus; // Corresponds to ride_status
  List<String>? languages; // Corresponds to languages
  Location? location; // Corresponds to location
  String? createdAt; // Corresponds to createdAt
  String? updatedAt; // Corresponds to updatedAt
  String? gender; // Corresponds to gender

  Driver({
    this.id,
    this.name,
    this.countryCode,
    this.phone,
    this.verified,
    this.referralCode,
    this.referralCodeBy,
    this.role,
    this.rideStatus,
    this.languages,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.gender,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["_id"],
        name: json["name"],
        countryCode: json["country_code"],
        phone: json["phone"],
        verified: json["verified"],
        referralCode: json["referral_code"],
        referralCodeBy: json["referral_code_by"],
        role: json["role"],
        rideStatus: json["ride_status"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        location: json["location"] != null ? Location.fromJson(json["location"]) : null,
        createdAt: json["createdAt"].toString(),
        updatedAt: json["updatedAt"].toString(),
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "country_code": countryCode,
        "phone": phone,
        "verified": verified,
        "referral_code": referralCode,
        "referral_code_by": referralCodeBy,
        "role": role,
        "ride_status": rideStatus,
        "languages": languages,
        "location": location?.toJson(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "gender": gender,
      };
}
