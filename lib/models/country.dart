// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

class CountryModel {
  final String? docId;
  final String? name;
  final int? createdAt;

  CountryModel({
    this.docId,
    this.name,
    this.createdAt,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    docId: json["docId"],
    name: json["name"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String countryID) => {
    "docId": countryID,
    "name": name,
    "createdAt": createdAt,
  };
}
