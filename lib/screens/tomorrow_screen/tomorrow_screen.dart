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
    return Scaffold(
      backgroundColor: Color(0xff0C0926),
      body: Column(
        children: [
          FutureBuilder<Response>(
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
                OneCallData? oneCallData = snapshot.data?.data as OneCallData?;
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
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(OneCallData oneCallData) {
    return Column(
      children: [
        Container(
          height: 330.h,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.linearColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70.h,
                    width: 115.w,
                    child: Image.network(
                      oneCallData.daily[0].weather[0].icon.getWeatherIconUrl(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        '${(oneCallData.daily[0].dailyTemp.day).toInt()}°',
                        style: TextStyle(
                          fontFamily: "MavenPro",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 90.sp,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      SizedBox(height: 5.h),
                      Text(
                        oneCallData.daily[0].weather[0].main,
                        style: TextStyle(
                          fontFamily: "Maven Pro",
                          color: Color(0xffE5E5E5),
                          fontSize: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SecondSmallWeatherInfo(oneCallData: oneCallData),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(7, (index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        oneCallData.daily[index + 1].dt.getParsedDateDay(),
                        style: AppTextStyle.openSans.copyWith(fontSize: 18.sp),
                      ),
                      Row(
                        children: [
                          Image.network(
                            oneCallData.daily[index + 1].weather[0].icon
                                .getWeatherIconUrl(),
                            height: 30.h,
                            width: 30.w,
                            color: Colors.white,
                            // height: ,
                          ),
                          Text(
                            oneCallData.daily[index + 1].weather[0].main,
                            style:
                                AppTextStyle.openSans.copyWith(fontSize: 18.sp),
                          ),
                        ],
                      ),
                      Text(
                        '${oneCallData.daily[index + 1].dailyTemp.day.toInt()}°',
                        style: AppTextStyle.openSans.copyWith(fontSize: 18.sp),
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        )
      ],
    );
  }
}
