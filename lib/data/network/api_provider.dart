import 'dart:convert';

import 'package:weather_app/data/model/detal/one_call_data.dart';
import 'package:weather_app/data/model/simple/weather_main_model.dart';
import 'package:weather_app/utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import '../model/response.dart';

class ApiProvider {
  static Future<Response> getSimpleWeatherInfoget(String city) async {
    Map<String, String> queryParams = {'appid': AppContants.apiKey, 'q': city};

    Uri uri = Uri.https(AppContants.baseUrl, '/data/2.5/weather', queryParams);

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        // JSON ma'lumotlarni tekshiring va modelga o'girishni bajarish
        dynamic jsonData = jsonDecode(response.body);
        if (jsonData != null && jsonData is Map<String, dynamic>) {
          return Response(
            data: WeatherMainModel.fromJson(jsonData),
          );
        } else {
          return Response(errorText: "Invalid JSON data");
        }
      } else {
        return Response(errorText: "Other Error: ${response.statusCode}");
      }
    } catch (error) {
      return Response(errorText: error.toString());
    }
  }

  //
  static Future<Response> getComplexWeatherInfo() async {
    Map<String, String> queryParams = {
      "lat": "41.2646",
      "lon": "69.2163",
      "units": "metric",
      "exclude": "minutely,current",
      "appid": AppContants.complexApiKey2,
    };

    Uri uri = Uri.https(
      AppContants.baseUrl,
      "/data/2.5/onecall",
      queryParams,
    );

    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return Response(
          data: OneCallData.fromJson(
            jsonDecode(response.body),
          ),
        );
      } else {
        return Response(errorText: "OTHER ERROR:${response.statusCode}");
      }
    } catch (error) {
      return Response(errorText: error.toString());
    }
  }
}
