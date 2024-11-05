import 'dart:convert';
import 'package:driver/constant/api_constant.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendOtp(
    String countryCode, String mobileNumber) async {
  final Map<String, String> payload = {
    "country_code": countryCode,
    "mobile_number": mobileNumber,
  };

  final response = await http.post(
    Uri.parse(baseURL + sendOtpEndpoint),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to send OTP: ${response.reasonPhrase}');
  }
}

Future<Map<String, dynamic>> verifyOtp(String otp, String mobileNumber) async {
  final Map<String, String> payload = {
    "otp": otp,
    "mobile_number": mobileNumber,
  };

  final response = await http.post(
    Uri.parse(baseURL + veriftOtpEndpoint),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to verify OTP: ${response.reasonPhrase}');
  }
}

Future<Map<String, dynamic>> createNewAccount(
    String name, String gender, String token) async {
  final Map<String, String> payload = {
    "name": name,
    "gender": gender,
    "referral_code": "ABPSYTD",
  };

  final response = await http.post(
    Uri.parse(baseURL + complpeteSignUpEndpoint),
    headers: {"Content-Type": "application/json", "token": token},
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to Create Account: ${response.reasonPhrase}');
  }
}
