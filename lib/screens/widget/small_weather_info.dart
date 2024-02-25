import 'package:flutter/material.dart';
import 'package:weather_app/data/model/simple/weather_main_model.dart';
import 'package:weather_app/utils/style/style.dart';

class SmallWeatherInfo extends StatelessWidget {
  const SmallWeatherInfo({
    super.key,
    required this.weatherMainModel,
  });

  final WeatherMainModel? weatherMainModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Image.asset("assets/images/Wind.png"),
            // SvgPicture.asset(
            //   "assets/icons/Wind.svg",
            //   color: Colors.red,
            // ),
            Text('${weatherMainModel?.windMain.speed.toInt()} km/h',
                style: AppTextStyle.openSans),
            Text(
              "Wind",
              style: AppTextStyle.openSans.copyWith(
                color: Color(0xffE8E8E8B2).withOpacity(0.7),
              ),
            )
          ],
        ),
        Column(
          children: [
            Image.asset("assets/images/Invert Colors.png"),
            Text('${weatherMainModel?.mainModel.humidity.toInt()} %',
                style: AppTextStyle.openSans),
            Text(
              "Humidity",
              style: AppTextStyle.openSans.copyWith(
                color: Color(0xffE8E8E8B2).withOpacity(0.7),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset("assets/images/Moisture.png"),
            Text('${weatherMainModel?.mainModel.pressure.toInt()} %',
                style: AppTextStyle.openSans),
            Text(
              "Chance of rain",
              style: AppTextStyle.openSans.copyWith(
                color: Color(0xffE8E8E8B2).withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
