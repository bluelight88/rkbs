import 'package:flutter/material.dart';

import '../constants/asset_constants.dart';
import '../constants/color_constants.dart';

final class CustomTheme {
  static ThemeData lightTheme() {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: ColorConstants.lightGreyColor,
      ),
    );
    return ThemeData(
      useMaterial3: false,
      fontFamily: AssetConstants.fontHelvetica,
      scaffoldBackgroundColor: ColorConstants.scaffoldBgColor,
      primaryColor: ColorConstants.primaryColor,
      colorScheme:
          const ColorScheme.light(primary: ColorConstants.primaryColor),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: ColorConstants.primaryColor),
        backgroundColor: ColorConstants.whiteColor,
        elevation: 1,
        titleTextStyle: TextStyle(
          color: ColorConstants.primaryColor,
          fontFamily: AssetConstants.fontHelvetica,
          height: 1,
          fontSize: 15,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorConstants.whiteColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorConstants.primaryColor,
        unselectedItemColor: ColorConstants.bottomNavBarUnselectedColor,
        selectedIconTheme: IconThemeData(color: ColorConstants.primaryColor),
        unselectedIconTheme:
            IconThemeData(color: ColorConstants.bottomNavBarUnselectedColor),
      ),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: ColorConstants.primaryColor),
      inputDecorationTheme: InputDecorationTheme(
        border: outlineInputBorder,
        hintStyle: const TextStyle(
          color: Color(0xFF848484),
          height: 1,
          fontFamily: AssetConstants.fontHelvetica,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        focusColor: const Color(0xFF848484),
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        prefixIconColor: ColorConstants.textFieldIconColor,
        suffixIconColor: ColorConstants.textFieldIconColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: ColorConstants.greyColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorConstants.primaryColor,
          shadowColor: ColorConstants.shadowColor,
          elevation: 5,
          padding: const EdgeInsetsDirectional.only(start: 30.0, end: 30.0),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(color: ColorConstants.primaryColor),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          iconColor: ColorConstants.primaryColor,
          foregroundColor: ColorConstants.primaryColor,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(ColorConstants.primaryColor),
      ),
      textTheme: TextTheme(
        // headline 1
        displayLarge: Typography.whiteMountainView.displayMedium
            ?.copyWith(height: 1, fontFamily: AssetConstants.fontHelvetica),
        // headline 2
        displayMedium: Typography.whiteMountainView.displayMedium
            ?.copyWith(height: 1, fontFamily: AssetConstants.fontHelvetica),
        // headline 3
        displaySmall: Typography.whiteMountainView.displayMedium
            ?.copyWith(height: 1, fontFamily: AssetConstants.fontHelvetica),
        // headline 4
        headlineMedium: Typography.whiteMountainView.displayMedium
            ?.copyWith(height: 1, fontFamily: AssetConstants.fontHelvetica),
        // headline 5
        headlineSmall: Typography.whiteMountainView.displayMedium
            ?.copyWith(height: 1, fontFamily: AssetConstants.fontHelvetica),
        // headline 6
        titleLarge: Typography.whiteMountainView.displayMedium
            ?.copyWith(height: 1, fontFamily: AssetConstants.fontHelvetica),
        // displayMedium: Typography.whiteMountainView.displayMedium?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 25,
        //   fontWeight: FontWeight.bold,
        // ),
        // displaySmall: Typography.whiteMountainView.displaySmall?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 20,
        //   fontWeight: FontWeight.w600,
        // ),
        // headlineMedium: Typography.whiteMountainView.headlineMedium?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 18,
        //   fontWeight: FontWeight.w600,
        // ),
        // headlineSmall: Typography.whiteMountainView.headlineSmall?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 16.0,
        //   fontWeight: FontWeight.w700,
        // ),
        // titleLarge: Typography.whiteMountainView.titleLarge?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 16.0,
        //   fontWeight: FontWeight.normal,
        // ),
        // // Title Medium fonts - for medium screen titles
        // titleMedium: Typography.whiteMountainView.titleMedium?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 13.0,
        //   fontWeight: FontWeight.w700,
        // ),
        // // Title Small fonts - for semiBold titles
        // titleSmall: Typography.whiteMountainView.titleSmall?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 11.0,
        //   fontWeight: FontWeight.w500,
        // ),
        // // Body Large fonts - for Patients name titles
        // bodyLarge: Typography.whiteMountainView.bodyLarge?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 14.0,
        // ),
        // // Body Medium fonts - for Medium common texts
        bodyMedium: Typography.whiteMountainView.bodyMedium?.copyWith(
            height: 1,
            color: ColorConstants.primaryColor,
            fontFamily: AssetConstants.fontHelvetica),
        // Body Small fonts - for Small common texts
        // bodySmall: Typography.whiteMountainView.bodySmall?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 11.0,
        //   fontWeight: FontWeight.w300,
        // ),
        // labelLarge: Typography.whiteMountainView.labelLarge?.copyWith(
        //   color: ColorConstants.blackColor,
        //   fontSize: 14.0,
        //   fontWeight: FontWeight.normal,
        // ),
        // labelSmall: Typography.whiteMountainView.labelSmall?.copyWith(
        //   color: ColorConstants.primaryColor,
        //   fontSize: 11.0,
        //   fontWeight: FontWeight.w500,
        // ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((state) {
          if (state.contains(WidgetState.selected) ||
              state.contains(WidgetState.focused) ||
              state.contains(WidgetState.pressed)) {
            return ColorConstants.primaryColor;
          }
          if (state.contains(WidgetState.error)) return Colors.red;
          if (state.contains(WidgetState.disabled)) {
            return ColorConstants.greyColor;
          }
          return null;
        }),
      ),
      dialogTheme: DialogTheme(
        titleTextStyle: Typography.whiteMountainView.displayLarge?.copyWith(
            color: Colors.black,
            fontSize: 18,
            fontFamily: AssetConstants.fontHelvetica),
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: ColorConstants.whiteColor,
        headerBackgroundColor: ColorConstants.primaryColor,
        headerForegroundColor: ColorConstants.whiteColor,
      ),
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: ColorConstants.whiteColor,
      ),
    );
  }

  static ThemeData darkTheme() => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      fontFamily: AssetConstants.fontHelvetica);
}
