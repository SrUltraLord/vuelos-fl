import 'dart:convert';

import 'package:vuelos_fl/src/models/ticket.dart';

UserTicketsResponse userTicketsResponseFromJson(String str) =>
    UserTicketsResponse.fromJson(json.decode(str));

String userTicketsResponseToJson(UserTicketsResponse data) =>
    json.encode(data.toJson());

class UserTicketsResponse {
  UserTicketsResponse({
    required this.ok,
    required this.message,
    required this.statusCode,
    required this.status,
    required this.data,
  });

  bool ok;
  dynamic message;
  String statusCode;
  int status;
  List<Ticket> data;

  factory UserTicketsResponse.fromJson(Map<String, dynamic> json) =>
      UserTicketsResponse(
        ok: json["ok"],
        message: json["message"],
        statusCode: json["statusCode"],
        status: json["status"],
        data: List<Ticket>.from(json["data"].map((x) => Ticket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "statusCode": statusCode,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
