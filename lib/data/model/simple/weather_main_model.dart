import 'package:weather_app/data/model/main/coord_model.dart';
import 'package:weather_app/data/model/main/main_in_main.dart';
import 'package:weather_app/data/model/main/sys_in_main.dart';
import 'package:weather_app/data/model/main/wind_in_main.dart';

import '../main/weather_model.dart';

class WeatherMainModel {
  final CoordModel coordModel;
  final List<WeatherModel> weatherModel;
  final String base;
  final MainInMain mainModel;
  final int visibility;
  final WindInMain windMain;
  final int cloudsAll;
  final int date; // Change data type to int
  final SysInMain sys;
  final int timeZone;
  final int id;
  final String name;
  final int code; // Change data type to int

  WeatherMainModel({
    required this.coordModel,
    required this.mainModel,
    required this.base,
    required this.name,
    required this.cloudsAll,
    required this.code,
    required this.date,
    required this.id,
    required this.sys,
    required this.weatherModel,
    required this.windMain,
    required this.visibility,
    required this.timeZone,
  });

  factory WeatherMainModel.fromJson(Map<String, dynamic> json) {
    return WeatherMainModel(
      sys: SysInMain.fromJson(json["sys"]),
      windMain: WindInMain.fromJson(json["wind"]),
      coordModel: CoordModel.fromJson(json["coord"]),
      id: json["id"],
      name: json["name"],
      code: json["cod"], // Changed to int
      date: json["dt"], // Changed to int
      base: json["base"],
      cloudsAll: json["clouds"]["all"],
      mainModel: MainInMain.fromJson(json["main"]),
      timeZone: json["timezone"],
      visibility: json["visibility"],
      weatherModel: (json["weather"] as List)
          .map((e) => WeatherModel.fromJson(e))
          .toList(),
    );
  }
}
