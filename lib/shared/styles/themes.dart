
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/shared/styles/colors.dart';

ThemeData lightTheme=ThemeData(
  backgroundColor:lightColor,
  scaffoldBackgroundColor:lightColor,
  primarySwatch:primarySwitchColor,
  fontFamily:"Roboto",
  appBarTheme: AppBarTheme(
    elevation:0.0,
    backgroundColor:lightColor,
    backwardsCompatibility:false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor:lightColor,
      statusBarBrightness:Brightness.dark,
      statusBarIconBrightness:Brightness.dark,

    ),
    titleTextStyle:TextStyle(
      fontFamily:"Roboto",
      color:Colors.black,
      fontSize:20.0.sp,
      overflow:TextOverflow.ellipsis,
    ),
    iconTheme:IconThemeData(
      color:Colors.black,
      size:30.0.sp,
    ),
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    backgroundColor: lightColor,
    elevation:40.0,
    selectedItemColor:primarySwitchColor,
    unselectedItemColor:Colors.grey,
    type:BottomNavigationBarType.fixed,
  ),
  textTheme:TextTheme(
    headline6:TextStyle(
      color:darkColor,
      fontSize:22.0.sp,
      fontWeight:FontWeight.bold,
    ),
    subtitle1:TextStyle(
      color:darkColor,
      fontSize:15.0.sp,
      fontWeight:FontWeight.bold,
      height:1.3.h,
    ),
  ),
);

ThemeData darkTheme=ThemeData(
  fontFamily:"Roboto",
  backgroundColor:HexColor('#515a5a'),
  scaffoldBackgroundColor:HexColor('#515a5a'),
  primarySwatch:primarySwitchColor,
  appBarTheme: AppBarTheme(
    elevation:0.0,
    backgroundColor:darkColor,
    backwardsCompatibility:false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarBrightness:Brightness.light,
      statusBarIconBrightness:Brightness.light,
      statusBarColor:darkColor,
    ),
    titleTextStyle:TextStyle(
      fontFamily:"Roboto",
      color:lightColor,
      fontSize:30.0.sp,
      // fontWeight:FontWeight.bold,
    ),
    iconTheme:IconThemeData(
      color:lightColor,
      size: 30.0.sp,
    ),
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    elevation: 40.0,
    type:BottomNavigationBarType.fixed,
    backgroundColor:darkColor,
    selectedItemColor:primarySwitchColor,
    unselectedItemColor:Colors.grey,
  ),
  textTheme:TextTheme(
    headline6:TextStyle(
      color:lightColor,
      fontSize:22.0.sp,
      fontWeight:FontWeight.bold,
    ),
    subtitle1:TextStyle(
      color:lightColor,
      fontSize:15.0.sp,
      fontWeight:FontWeight.bold,
      height:1.3.h,
    ),
  ),
);