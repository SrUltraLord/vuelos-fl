import 'dart:convert';

import 'package:vuelos_fl/src/models/flight.dart';

FlightResponse flightResponseFromJson(String str) =>
    FlightResponse.fromJson(json.decode(str));

String flightResponseToJson(FlightResponse data) => json.encode(data.toJson());

class FlightResponse {
  bool? ok;
  String? message;
  String? statusCode;
  int status;
  Flight? data;

  FlightResponse({
    required this.ok,
    required this.message,
    required this.statusCode,
    required this.status,
    required this.data,
  });

  factory FlightResponse.fromJson(Map<String, dynamic> json) => FlightResponse(
        ok: json["ok"],
        message: json["message"],
        statusCode: json["statusCode"],
        status: json["status"],
        data: json["data"] != null ? Flight.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok ?? false,
        "message": message,
        "statusCode": statusCode,
        "status": status,
        "data": data?.toJson(),
      };
}
