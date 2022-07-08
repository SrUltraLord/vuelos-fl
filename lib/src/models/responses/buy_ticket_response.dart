import 'dart:convert';

BuyTicketResponse buyTicketResponseFromJson(String str) =>
    BuyTicketResponse.fromJson(json.decode(str));

String buyTicketResponseToJson(BuyTicketResponse data) =>
    json.encode(data.toJson());

class BuyTicketResponse {
  BuyTicketResponse({
    required this.ok,
    required this.message,
  });

  bool ok;
  String message;

  factory BuyTicketResponse.fromJson(Map<String, dynamic> json) =>
      BuyTicketResponse(
        ok: json["ok"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
      };
}
