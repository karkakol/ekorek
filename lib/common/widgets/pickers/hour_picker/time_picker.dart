import 'package:flutter/material.dart';
import 'package:time_picker_widget/time_picker_widget.dart' as t;

class TimePickerState {
  late final TimeOfDay initialTime;

  TimePickerState({
    required this.initialTime,
  });

  TimePickerState.now() {
    final now = TimeOfDay.now();
    initialTime = now;
  }
}

class TimePicker {
  static Future<TimeOfDay?> show({required BuildContext context, required TimePickerState pickerState}) async {
    final initialTime = pickerState.initialTime.replacing(minute: pickerState.initialTime.minute + 15 - pickerState
        .initialTime.minute % 15);
    return t.showCustomTimePicker(
        context: context,
        initialTime: initialTime,
        onFailValidation: (_) {},
        initialEntryMode: t.TimePickerEntryMode.dial,
        selectableTimePredicate: (time) {
          if (time == null) return true;
          return time.minute % 15 == 0;
        });
  }
}
