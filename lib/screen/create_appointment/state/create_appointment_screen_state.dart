import 'package:ekorek/di/injector.dart';
import 'package:ekorek/model/user/user.dart';
import 'package:ekorek/service/appointment_service/appointments_service.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:uuid/uuid.dart';

import '../../../app/state/user/user_state.dart';
import '../../../common/widgets/pickers/day_picker/day_picker.dart';
import '../../../common/widgets/pickers/hour_picker/time_picker.dart';
import '../../../model/appointment/appointment.dart';
import '../../../model/subject/subject.dart';
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

  final bool submitEnabled;
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
    required this.submitEnabled,
  });

  String get subject => screenArgs.subject;

  UserTutor get tutor => screenArgs.tutor;
}

const _durationStep = 15;

CreateAppointmentScreenState useCreateAppointmentScreenState({required CreateAppointmentScreenArgs args, required
Function(Appointment) navigateToDetailedMeeting}) {
  final appointmentService = useInjected<AppointmentsService>();
  final userState = useProvided<UserState>();

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

  calculatePrice(Duration time) {
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
    submitState.run(() async {
      final calendarData = pickedDayState.value!;
      final dayData = startTimeState.value!;

      final startTime = DateTime(
        calendarData.year,
        calendarData.month,
        calendarData.day,
        dayData.hour,
        dayData.minute,
      );

      final endTime = startTime.add(lessonDurationState.value);

      final newAppointment = Appointment(
        endTime: endTime.toUtc(),
        price: priceState.value,
        startTime: startTime.toUtc(),
        lessonLength: lessonDurationState.value,
        tutorId: args.tutor.id,
        studentId: userState.user!.id,
        subject: Subject(name: args.subject, pricePerHour: args.tutor.subjects[args.subject]!),
        uuid: Uuid().v4(),
      );

      await appointmentService.add(newAppointment);
      navigateToDetailedMeeting(newAppointment);
    });
  }

  bool submitEnabled(){
    if(pickedDayState.value == null) return false;
    if(startTimeState.value == null) return false;
    if(lessonDurationState.value.inMinutes == 0) return false;

    return true;
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
    submitEnabled: submitEnabled()
  );
}
