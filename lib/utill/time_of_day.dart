import 'package:flutter/material.dart';

extension TimeOfDayX on TimeOfDay?{
  String get simpleHour {
    if(this == null) return '-- : --';
    int hour = this!.hour;
    String hourText = hour.toString();

    if(hour < 10) {
      hourText = "0"+hourText;
    }

    int minutes = this!.minute;

    String minuteText = minutes.toString();

    if(minutes < 10) {
      minuteText = "0"+minuteText;
    }

    return "$hourText : $minuteText";
  }
}