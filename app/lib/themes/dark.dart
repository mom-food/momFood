import 'package: flutter/material.dart';
import 'colors.dart';

final ThemeData darkTheme= ThemeData(
    primaryColor: AppColors.primaryDark,
    accentColor: AppColors.secondaryDark, 
    scaffoldBackgroundColor: AppColors.textColorDark,
    textTheme: TextTheme( 
        bodyText1: TextStle(Color: AppColors.textColorDark),
    ))