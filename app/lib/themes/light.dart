import 'package: flutter/material.dart';
import 'colors.dart';

final ThemeData lightTheme= ThemeData(
    primaryColor: AppColors.primaryLight,
    accentColor: AppColors.secondaryLight, 
    scaffoldBackgroundColor: AppColors.textColorLight,
    textTheme: TextTheme( 
        bodyText1: TextStle(Color: AppColors.textColorLight),
    ))