import 'dart:convert';

Models modelsFromJson(String str) => Models.fromJson(json.decode(str));

String modelsToJson(Models data) => json.encode(data.toJson());

class Models {
  Models({
    required this.name,
    required this.number,
  });

  String name;
  int number;

  factory Models.fromJson(Map<String, dynamic> json) => Models(
    name: json["name"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "number": number,
  };
}