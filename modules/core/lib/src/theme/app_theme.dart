import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData appTheme(BuildContext context) => ThemeData(
    primaryColor: AppColors.desire,
    primaryColorDark: AppColors.vividAuburn,
    textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
    inputDecorationTheme: const InputDecorationTheme(
        border:
            OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: AppColors.queenBlue)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: AppColors.queenBlue)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: AppColors.vividAuburn)),
        fillColor: AppColors.inputColor,
        hintStyle: TextStyle(color: AppColors.queenBlue),
        labelStyle: TextStyle(color: AppColors.queenBlue)),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.desire));
