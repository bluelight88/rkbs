import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

extension StringExtension on String {
  bool get isPlaceHolder => this == AppConstants.stringPlaceHolder;

  String capitalize() =>
      isNotEmpty ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}" : "";

  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeAllFirstLetter() {
    return capitalizeFirstLetter().splitMapJoin(
      RegExp(r' '),
      onNonMatch: (str) => str.toString().capitalize(),
    );
  }
}

extension DateExtension on DateTime {
  String formatDate(String pattern) {
    try {
      return DateFormat(pattern).format(this);
    } catch (e) {
      return "";
    }
  }

  /// getDaysInMonth return total days for selected date's month
  int getDaysInMonth() {
    final int month = this.month, year = this.year;
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31,
    ];
    return daysInMonth[month - 1];
  }

  /// getDatesBetweenTwoDates return all the dates between specified startDate and endDate
  List<DateTime> getDatesBetweenTwoDates(DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(this).inDays; i++) {
      days.add(
        DateTime(
          year,
          month,
          // In Dart you can set more than. 30 days, DateTime will do the trick
          day + i,
        ),
      );
    }
    return days;
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get value =>
      "${hour == 0 ? '00' : hour}:${minute == 0 ? '00' : minute}";
}
