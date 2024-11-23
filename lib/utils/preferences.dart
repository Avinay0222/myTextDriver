import 'dart:convert';

import 'package:driver/app/models/booking_model.dart';
import 'package:driver/app/models/driver_user_model.dart';
import 'package:driver/app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

String globalToken = '';

class Preferences {
  static const languageCodeKey = "languageCodeKey";
  static const themKey = "themKey";
  static const isFinishOnBoardingKey = "isFinishOnBoardingKey";
  static const String userLoginStatus = "USER_LOGIN_STATUS";
  static const String fcmToken = "FCM_TOKEN";
  static double driverLat = 0, driverLong = 0;
  static RideData? rideModule;

  static DriverUserModel? userModel;

  static Future<bool> getBoolean(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? false;
  }

  static Future<void> setBoolean(String key, bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? "";
  }

  static Future<void> setString(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key) ?? 0;
  }

  static Future<void> setInt(String key, int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(key, value);
  }

  static Future<void> clearSharPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  static Future<void> clearKeyData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }

  static Future<String> getFcmToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    globalToken = pref.getString(fcmToken) ?? "";
    return globalToken;
  }

  static Future<void> setFcmToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(fcmToken, token);
  }

  static Future<void> setUserLoginStatus(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(userLoginStatus, value);
  }

  static Future<bool> getUserLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(userLoginStatus) ?? false;
  }

  static Future<void> setDriverUserModel(DriverUserModel userModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Preferences.userModel = userModel;
    String jsonString = json.encode(userModel.toJson());
    await saveUserModelOnline(userModel);
    await pref.setString('driverUserModel', jsonString);
  }

  static Future<DriverUserModel?> getDriverUserModel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString('driverUserModel');
    if (jsonString != null) {
      Preferences.userModel = DriverUserModel.fromJson(json.decode(jsonString));
      return userModel;
    }
    return null;
  }
}
