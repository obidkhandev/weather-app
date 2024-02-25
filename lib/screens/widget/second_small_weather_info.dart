import 'package:flutter/material.dart';
import 'package:weather_app/data/model/detal/one_call_data.dart';
import 'package:weather_app/utils/style/style.dart';

class SecondSmallWeatherInfo extends StatelessWidget {
  const SecondSmallWeatherInfo({
    super.key,
    required this.oneCallData,
  });

  final OneCallData oneCallData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Image.asset("assets/images/Wind.png"),
            Text('${oneCallData.daily[1].windSpeed.toInt()} km/h',
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
            Text('${oneCallData.daily[1].humidity} %',
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
            Text('${oneCallData.daily[1].pressure.toInt()} %',
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
