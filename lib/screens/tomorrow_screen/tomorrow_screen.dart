import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/data/model/detal/one_call_data.dart';
import 'package:weather_app/data/model/response.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/screens/widget/second_small_weather_info.dart';
import 'package:weather_app/screens/widget/top_icons.dart';
import 'package:weather_app/utils/colors/app_colors.dart';
import 'package:weather_app/utils/extensions/extensions.dart';
import 'package:weather_app/utils/style/style.dart';

class TomorrowScreen extends StatefulWidget {
  const TomorrowScreen({Key? key}) : super(key: key);

  @override
  State<TomorrowScreen> createState() => _TomorrowScreenState();
}

class _TomorrowScreenState extends State<TomorrowScreen> {
  final WeatherRepository weatherRepository = WeatherRepository();

  @override
  Widget build(BuildContext context) {
    bool isDay = true;
    isDay = 07 <= DateTime.now().hour;
    return Scaffold(
      backgroundColor: const Color(0xff0C0926),
      body: Column(
        children: [
          Container(
            height: 330.h,
            decoration: BoxDecoration(
              gradient: isDay
                  ? const LinearGradient(
                      colors: AppColors.linearColor,
                    )
                  : AppColors.night,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: FutureBuilder<Response>(
              future: weatherRepository.getComplexWeatherInfo(),
              builder: (context, AsyncSnapshot<Response> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  OneCallData? oneCallData =
                      snapshot.data?.data as OneCallData?;
                  if (oneCallData != null) {
                    return _buildWeatherInfo(oneCallData);
                  } else {
                    return Center(
                      child: Text(
                        "Data parsing error",
                        style: TextStyle(color: Colors.red, fontSize: 24.sp),
                      ),
                    );
                  }
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<Response>(
              future: weatherRepository.getComplexWeatherInfo(),
              builder: (context, AsyncSnapshot<Response> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  OneCallData? oneCallData =
                      snapshot.data?.data as OneCallData?;
                  if (oneCallData != null) {
                    return _buildWeatherDailyInfo(oneCallData);
                  } else {
                    return Center(
                      child: Text(
                        "Data parsing error",
                        style: TextStyle(color: Colors.red, fontSize: 24.sp),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDailyInfo(OneCallData oneCallData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(7, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    oneCallData.daily[index + 1].dt.getParsedDateDay(),
                    style: AppTextStyle.openSans.copyWith(fontSize: 22.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        oneCallData.daily[index + 1].weather[0].icon
                            .getWeatherIconUrl(),
                        height: 50.h,
                        width: 50.w,
                        color: Colors.white,
                        // height: ,
                      ),
                      Text(
                        oneCallData.daily[index + 1].weather[0].main,
                        style: AppTextStyle.openSans.copyWith(fontSize: 22.sp),
                      ),
                    ],
                  ),
                  Text(
                    '${oneCallData.daily[index + 1].dailyTemp.day.toInt()}°',
                    style: AppTextStyle.openSans.copyWith(fontSize: 22.sp),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(OneCallData oneCallData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TopIcons(
          onTap: () => Navigator.pop(context),
          icon: Icons.arrow_back,
        ),
        Text(
          "Tomorrow",
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
              width: 100.w,
              child: Image.network(
                oneCallData.daily[0].weather[0].icon.getWeatherIconUrl(),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 50.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${(oneCallData.daily[0].dailyTemp.day).toInt()}°',
                  style: TextStyle(
                    fontFamily: "MavenPro",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 90.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          oneCallData.daily[0].weather[0].main,
          style: TextStyle(
            fontFamily: "Maven Pro",
            color: Color(0xffE5E5E5),
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SecondSmallWeatherInfo(oneCallData: oneCallData),
        ),
      ],
    );
  }
}
