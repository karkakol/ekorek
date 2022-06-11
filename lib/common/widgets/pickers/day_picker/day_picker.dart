import 'package:flutter/material.dart';

class DayPickerState {
 late final DateTime initialDate;
 late final DateTime firstDate;
 late final DateTime lastDate;

  DayPickerState({
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
  });

   DayPickerState.now(){
     final now =  DateTime.now();
     firstDate = now;
     initialDate = now.add(const Duration(days: 1));
     lastDate = now.add(const Duration(days: 14));
   }
}

class DayPicker {
  static Future<DateTime?> show({required BuildContext context, required DayPickerState pickerState}) async {
    return showDatePicker(
      context: context,
      initialDate: pickerState.initialDate,
      firstDate: pickerState.firstDate,
      lastDate: pickerState.lastDate,
    );
  }
}
