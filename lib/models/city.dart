// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

class CityModel {
  final String? docId;
  final String? countryID;
  final String? city;
  final int? population;
  final bool? visited;
  final List<dynamic>? favorite;
  final int? createdAt;

  CityModel({
    this.docId,
    this.countryID,
    this.city,
    this.population,
    this.visited,
    this.favorite,
    this.createdAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    docId: json["docId"],
    countryID: json["countryID"],
    city: json["city"],
    population: json["population"],
    visited: json["visited"],
    favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String cityID) => {
    "docId": cityID,
    "countryID": countryID,
    "city": city,
    "population": population,
    "visited": visited,
    "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
    "createdAt": createdAt,
  };
}
