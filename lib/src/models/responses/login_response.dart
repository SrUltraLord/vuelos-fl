import 'dart:convert';

import 'package:vuelos_fl/src/models/user.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? ok;
  String? message;
  String? statusCode;
  int status;
  User? data;

  LoginResponse({
    required this.ok,
    required this.message,
    required this.statusCode,
    required this.status,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        message: json["message"],
        statusCode: json["statusCode"],
        status: json["status"],
        data: json["data"] != null ? User.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok ?? false,
        "message": message,
        "statusCode": statusCode,
        "status": status,
        "data": data?.toJson(),
      };
}
