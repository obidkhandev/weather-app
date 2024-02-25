import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/data/model/simple/weather_main_model.dart';
import 'package:weather_app/utils/extensions/extensions.dart';

class WeatherIcon extends StatelessWidget {
  final double height;
  const WeatherIcon({
    super.key,
    required this.weatherMainModel,
    required this.height,
  });

  final WeatherMainModel? weatherMainModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          offset: Offset(8, 8),
          blurRadius: 25.r,
          color: const Color.fromARGB(0, 116, 116, 156).withOpacity(0.1),
        ),
      ]),
      child: Image.network(
        weatherMainModel!.weatherModel[0].icon.getWeatherIconUrl(),
        color: Colors.grey.shade500,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
