// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

class CityModel {
  final String? docId;
  final String? city;
  final int? population;
  final bool? visited;
  final int? createdAt;

  CityModel({
    this.docId,
    this.city,
    this.population,
    this.visited,
    this.createdAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    docId: json["docId"],
    city: json["city"],
    population: json["population"],
    visited: json["visited"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String cityID) => {
    "docId": cityID,
    "city": city,
    "population": population,
    "visited": visited,
    "createdAt": createdAt,
  };
}
