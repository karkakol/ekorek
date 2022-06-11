import 'package:freezed_annotation/freezed_annotation.dart';

import '../subject/subject.dart';

part 'appointment.freezed.dart';

part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  const Appointment._();

  @JsonSerializable(explicitToJson: true)
  factory Appointment({
    //uuid będzie sie składać z uuid+studentId+tutorId
    required String uuid,
    required String studentId,
    required String tutorId,
    required DateTime startTime,
    required DateTime endTime,
    required Duration lessonLength,
    required Subject subject,
    required double price,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);
}
