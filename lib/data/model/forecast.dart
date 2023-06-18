// To parse this JSON data, do
//
//     final forecastResponse = forecastResponseFromJson(jsonString);

import 'dart:convert';

ForecastResponse forecastResponseFromJson(String str) =>
    ForecastResponse.fromJson(json.decode(str));

String forecastResponseToJson(ForecastResponse data) =>
    json.encode(data.toJson());

class ForecastResponse {
  String? cod;
  int? message;
  int? cnt;
  List<ListForecast>? list;
  City? city;

  ForecastResponse({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) =>
      ForecastResponse(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ListForecast>.from(
            json["list"].map((x) => ListForecast.fromJson(x))),
        city: City?.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
        "city": city?.toJson(),
      };
}

class City {
  int? id;
  String? name;

  String? country;

  City({
    this.id,
    this.name,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
      };
}

class ListForecast {
  int? dt;
  MainClass? main;
  List<Weather>? weather;
  DateTime? dtTxt;
  Wind? wind;

  ListForecast({this.dt, this.main, this.weather, this.dtTxt, this.wind});

  factory ListForecast.fromJson(Map<String, dynamic> json) => ListForecast(
        dt: json["dt"],
        main: MainClass?.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        dtTxt: DateTime.parse(json["dt_txt"]),
        wind: Wind.fromJson(json["wind"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main?.toJson(),
        "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
        "dt_txt": dtTxt!.toIso8601String(),
        "wind": wind?.toJson(),
      };
}

class MainClass {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
      };
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"]!,
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };
}
