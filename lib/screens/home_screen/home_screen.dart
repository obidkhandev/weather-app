import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/data/model/detal/one_call_data.dart';
import 'package:weather_app/data/model/response.dart';
import 'package:weather_app/data/model/simple/weather_main_model.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/screens/home_screen/widget/hourly_widget.dart';
import 'package:weather_app/screens/tomorrow_screen/tomorrow_screen.dart';
import 'package:weather_app/screens/widget/small_weather_info.dart';
import 'package:weather_app/screens/widget/top_icons.dart';
import 'package:weather_app/screens/widget/weather_icon.dart';
import 'package:weather_app/utils/colors/app_colors.dart';
import 'package:weather_app/utils/extensions/extensions.dart';
import 'package:weather_app/utils/style/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherRepository weatherRepository = WeatherRepository();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          FutureBuilder<Response?>(
            future: weatherRepository.getSimpleWeatherInfoget("Tashkent"),
            builder: (context, AsyncSnapshot<Response?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: TextStyle(color: Colors.red, fontSize: 24.sp),
                  ),
                );
              } else if (snapshot.data == null) {
                return Center(
                  child: Text(
                    "No data available",
                    style: TextStyle(color: Colors.red, fontSize: 24.sp),
                  ),
                );
              } else {
                WeatherMainModel? weatherMainModel =
                    (snapshot.data?.data as WeatherMainModel?);
                if (weatherMainModel != null) {
                  print("object");
                  return _buildWeatherInfo(weatherMainModel);
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

  Widget _buildWeatherInfo(WeatherMainModel weatherMainModel) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 30.h,
            left: 20.w,
            right: 20.w,
          ),
          height: 520.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.secondLinearColor,
            ),
          ),
          child: Column(
            children: [
              TopIcons(onTap: () {
                showAlertDialog(BuildContext context) {
                  // set up the buttons
                  Widget cancelButton = TextButton(
                    child: Text("Cancel"),
                    onPressed: () {},
                  );
                  Widget continueButton = TextButton(
                    child: Text("Continue"),
                    onPressed: () {},
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("AlertDialog"),
                    content: TextFormField(),
                    actions: [
                      cancelButton,
                      continueButton,
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.white),
                  Text(
                    weatherMainModel.name,
                    style: TextStyle(color: Colors.white, fontSize: 22.sp),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              WeatherIcon(weatherMainModel: weatherMainModel, height: 110.h),
              SizedBox(
                height: 100.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(weatherMainModel.mainModel.temp - 273.15).toInt()}',
                      style: TextStyle(
                        fontFamily: "MavenPro",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 90.sp,
                      ),
                    ),
                    Text(
                      "°",
                      style: TextStyle(
                        color: Colors.white,
                        height: 4.h,
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                weatherMainModel.weatherModel[0].main,
                style: TextStyle(
                  fontFamily: "Maven Pro",
                  color: Color(0xffFAFD74),
                  fontSize: 48.sp,
                ),
              ),
              Text(
                weatherMainModel.date.getParsedDateDayAndMonth(),
                style: TextStyle(
                  color: Color(0xffE8E8E8),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Divider(color: Colors.white),
              ),
              SizedBox(height: 10.h),
              SmallWeatherInfo(weatherMainModel: weatherMainModel),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: AppTextStyle.openSans.copyWith(fontSize: 22),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TomorrowScreen()),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "7 days",
                      style: AppTextStyle.openSans.copyWith(fontSize: 22.sp),
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,
                        color: Colors.white, size: 20.spMin),
                  ],
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<Response>(
          future: weatherRepository.getComplexWeatherInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(color: Colors.red, fontSize: 24.sp),
                ),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text(
                  "No data available",
                  style: TextStyle(color: Colors.red, fontSize: 24.sp),
                ),
              );
            } else {
              OneCallData? oneCallData = (snapshot.data?.data as OneCallData?);
              if (oneCallData != null) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(oneCallData.hourly.length, (index) {
                      var hourly = oneCallData.hourly[index];
                      return HourlyItemWidget(
                        hourly: hourly,
                        onTap: () {
                          if (mounted) {
                            activeIndex = index;
                            // setState(() {});
                          }
                        },
                        isActiveColor: activeIndex == index ? true : false,
                      );
                    }),
                  ),
                );
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
    );
  }
}
