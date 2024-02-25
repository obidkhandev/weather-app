import 'package:weather_app/data/network/api_provider.dart';

import '../model/response.dart';

class WeatherRepository {
  Future<Response> getSimpleWeatherInfoget(String city) =>
      ApiProvider.getSimpleWeatherInfoget(city);

  Future<Response> getComplexWeatherInfo() =>
      ApiProvider.getComplexWeatherInfo();
}
