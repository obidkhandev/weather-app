import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xff0C0926);
  static const Color primaryColor = Color(0xff2352CB);
  static const List<Color> linearColor = [
    Color(0xff0648F1),
    Color(0xff11ACFF),
    Color(0xff00D1FF),
  ];
  static const List<Color> secondLinearColor = [
    Color(0xff00D1FF),
    Color(0xff11ACFF),
    Color(0xff0648F1),
  ];

  
  static const LinearGradient morning = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF108DC7),
      Color(0xFFEF8E38),
    ],
  );
  static const LinearGradient night = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF0F2027),
      Color(0xFF2C5364),
      Color(0xFF203A43),
    ],
  );
}
