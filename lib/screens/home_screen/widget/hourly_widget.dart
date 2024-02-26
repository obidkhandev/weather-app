import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/data/model/detal/hourly_item/hourly_item.dart';
import 'package:weather_app/utils/colors/app_colors.dart';
import 'package:weather_app/utils/extensions/extensions.dart';
import 'package:weather_app/utils/style/style.dart';

class HourlyItemWidget extends StatefulWidget {
  final VoidCallback onTap;
  final HourlyItem hourly;
  final bool isActiveColor;
  const HourlyItemWidget({
    super.key,
    required this.hourly,
    required this.onTap,
    required this.isActiveColor,
  });

  @override
  State<HourlyItemWidget> createState() => _HourlyItemWidgetState();
}

class _HourlyItemWidgetState extends State<HourlyItemWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDay = false;
    isDay = 07 <= DateTime.now().hour;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        height: 100.h,
        width: 75.w,
        decoration: BoxDecoration(
          // color: Color(0xff2352CB),
          gradient: isDay
              ? LinearGradient(
                  colors: widget.isActiveColor
                      ? AppColors.linearColor
                      : [Color(0xff2352CB), Color(0xff2352CB)],
                )
              : AppColors.night,

          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text(
              '${widget.hourly.humidity} %',
              style: AppTextStyle.openSans.copyWith(fontSize: 14.sp),
            ),
            Image.network(
              widget.hourly.weather[0].icon.getWeatherIconUrl(),
              color: Colors.white,
              height: 55.h,
              width: 55.w,
            ),
            Text(
              widget.hourly.dt.getParsedHour(),
              style: AppTextStyle.openSans
                  .copyWith(fontSize: 12.sp, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
