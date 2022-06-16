import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
            scaffoldBackgroundColor: HexColor('333739'),
             primarySwatch:defaultColor ,
           
            appBarTheme:  AppBarTheme(
            
              systemOverlayStyle:  SystemUiOverlayStyle(
                statusBarColor:  HexColor('333739'),
                statusBarIconBrightness: Brightness.light
              ),
              backgroundColor:  HexColor('333739'),
              elevation: 0,
               titleTextStyle:  const TextStyle(
                 color: Colors.white,
                 fontSize: 20,
                 fontWeight: FontWeight.bold
               ),
               iconTheme:  const IconThemeData(
                 color: Colors.white
               ),
            ),
            floatingActionButtonTheme:  const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange
            ),
            bottomNavigationBarTheme:  BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20,
              backgroundColor: HexColor('333739'),
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white
              )
            ),
            fontFamily: 'Poppins',
          );

          ThemeData lightTheme = ThemeData(
            primarySwatch: defaultColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme:   const AppBarTheme(
             
              systemOverlayStyle:  SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark
              ),
              backgroundColor: Colors.white,
              elevation: 0,
               titleTextStyle: TextStyle(
                 color: Colors.black,
                 fontSize: 20,
                 fontWeight: FontWeight.bold
               ),
               iconTheme: IconThemeData(
                 color: Colors.black
               ),
            ),
            floatingActionButtonTheme:   const FloatingActionButtonThemeData(
              backgroundColor: defaultColor
            ),
            bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              elevation: 20,
               backgroundColor: Colors.white
            ),
             textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black
              )
            ),
             fontFamily: 'Poppins',
          );