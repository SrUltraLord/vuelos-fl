import 'dart:convert';

import 'package:vuelos_fl/src/models/flight.dart';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

class Ticket {
  Ticket({
    required this.id,
    required this.flight,
    required this.dateBought,
  });

  int id;
  Flight flight;
  DateTime dateBought;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        flight: Flight.fromJson(json["flight"]),
        dateBought: DateTime.parse(json["dateBought"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "flight": flight.toJson(),
        "dateBought":
            "${dateBought.year.toString().padLeft(4, '0')}-${dateBought.month.toString().padLeft(2, '0')}-${dateBought.day.toString().padLeft(2, '0')}",
      };
}
