import 'package:flutter/widgets.dart';

import 'app_colors.dart';

class AppStyle {
  Color color = AppColors.textColor;
  FontWeight weight = FontWeight.normal;
  double height = 1.1;

  final double size;

  AppStyle.h1() : size = 32.0;

  AppStyle.h2() : size = 22.0;

  AppStyle.h3() : size = 20.0;

  AppStyle.p1() : size = 18.0;

  AppStyle.p2() : size = 14.0;

  AppStyle.custom(this.size);

  AppStyle withColor(Color color) {
    this.color = color;
    return this;
  }

  AppStyle withHeight(double value) {
    height = value;
    return this;
  }

  AppStyle get normal {
    weight = FontWeight.normal;
    return this;
  }

  AppStyle get medium {
    weight = FontWeight.w500;
    return this;
  }

  AppStyle get bold {
    weight = FontWeight.bold;
    return this;
  }

  AppStyle get semiBold {
    weight = FontWeight.w600;
    return this;
  }

  build() => TextStyle(fontSize: size, color: color, fontWeight: weight, height: height);
}
