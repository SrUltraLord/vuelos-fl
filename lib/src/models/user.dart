import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.userId,
    required this.nui,
    required this.name,
    required this.lastName,
    required this.email,
  });

  int userId;
  String nui;
  String name;
  String lastName;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        nui: json["nui"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nui": nui,
        "name": name,
        "lastName": lastName,
        "email": email,
      };
}
