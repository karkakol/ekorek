import 'package:ekorek/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../../../common/widgets/pickers/day_picker/day_picker.dart';
import '../../../common/widgets/pickers/hour_picker/time_picker.dart';
import '../../../utill/hooks/use_full_state.dart';
import 'create_appointemtn_screen_args.dart';

class CreateAppointmentScreenState {
  final FullState<DateTime?> pickedDayState;
  final FullState<TimeOfDay?> startTimeState;
  final FullState<Duration> lessonDurationState;

  final double lessonPrice;

  final Function(BuildContext) pickDay;
  final Function(BuildContext) pickTime;

  final Function() addTime;
  final Function() removeTime;

  final CreateAppointmentScreenArgs screenArgs;

  final Function() submit;
  final MutableSubmitState submitState;

  const CreateAppointmentScreenState({
    required this.lessonDurationState,
    required this.pickedDayState,
    required this.startTimeState,
    required this.pickDay,
    required this.pickTime,
    required this.addTime,
    required this.removeTime,
    required this.screenArgs,
    required this.lessonPrice,
    required this.submitState,
    required this.submit,
  });

  String get subject => screenArgs.subject;

  UserTutor get tutor => screenArgs.tutor;
}

const _durationStep = 15;

CreateAppointmentScreenState useCreateAppointmentScreenState({required CreateAppointmentScreenArgs args}) {
  final pickedDayState = useFullState<DateTime?>(null);
  final startTimeState = useFullState<TimeOfDay?>(null);
  final lessonDurationState = useFullState<Duration>(Duration.zero);

  final priceState = useRef<double>(0.0);

  pickDay(BuildContext context) async {
    final day = await DayPicker.show(context: context, pickerState: DayPickerState.now());
    pickedDayState.setValue(day);
  }

  pickTime(BuildContext context) async {
    if (pickedDayState.value == null) return;
    final day = await TimePicker.show(context: context, pickerState: TimePickerState.now());
    startTimeState.setValue(day);
  }

  calculatePrice(Duration time){
    final subjectPrice = args.tutor.subjects[args.subject]!;
    final lessonPrice = time.inMinutes * subjectPrice / 60;

    final priceText = lessonPrice.toStringAsFixed(2);
    final rounded = double.parse(priceText);

    priceState.value = rounded;
  }

  addTime() {
    if (lessonDurationState.value.inMinutes >= 180) return;
    final newDuration = Duration(minutes: lessonDurationState.value.inMinutes + _durationStep);
    calculatePrice(newDuration);
    lessonDurationState.setValue(newDuration);
  }

  removeTime() {
    if (lessonDurationState.value.inMinutes <= 0) return;
    final newDuration = Duration(minutes: lessonDurationState.value.inMinutes - _durationStep);
    calculatePrice(newDuration);
    lessonDurationState.setValue(newDuration);
  }

  final submitState = useSubmitState();


  submit() {
     submitState.run(
            () async {
          await Future.delayed(Duration(milliseconds: 1000));
        }
    );
  }


  return CreateAppointmentScreenState(
    startTimeState: startTimeState,
    lessonDurationState: lessonDurationState,
    pickedDayState: pickedDayState,
    pickDay: pickDay,
    pickTime: pickTime,
    addTime: addTime,
    removeTime: removeTime,
    screenArgs: args,
    lessonPrice: priceState.value,
    submitState: submitState,
    submit: submit,
  );
}
