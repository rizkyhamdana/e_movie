// To parse this JSON data, do
//
//     final cityResponse = cityResponseFromJson(jsonString);

import 'dart:convert';

List<CityResponse> cityResponseFromJson(String str) => List<CityResponse>.from(
    json.decode(str).map((x) => CityResponse.fromJson(x)));

String cityResponseToJson(List<CityResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityResponse {
  final String name;

  final double lat;
  final double lon;
  final String country;
  final String state;

  CityResponse({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
      };
}
