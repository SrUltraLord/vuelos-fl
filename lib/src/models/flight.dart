// To parse this JSON data, do
//
//     final flight = flightFromJson(jsonString);

import 'dart:convert';

Flight flightFromJson(String str) => Flight.fromJson(json.decode(str));

String flightToJson(Flight data) => json.encode(data.toJson());

class Flight {
  int id;
  String number;
  String cityOrigin;
  String cityDestination;
  double cost;
  String dateDeparture;
  String timeDeparture;

  Flight({
    required this.id,
    required this.number,
    required this.cityOrigin,
    required this.cityDestination,
    required this.cost,
    required this.dateDeparture,
    required this.timeDeparture,
  });

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        id: json["id"],
        number: json["number"],
        cityOrigin: json["cityOrigin"],
        cityDestination: json["cityDestination"],
        cost: json["cost"],
        dateDeparture: json["dateDeparture"],
        timeDeparture: json["timeDeparture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "cityOrigin": cityOrigin,
        "cityDestination": cityDestination,
        "cost": cost,
        "dateDeparture": dateDeparture,
        "timeDeparture": timeDeparture,
      };
}
