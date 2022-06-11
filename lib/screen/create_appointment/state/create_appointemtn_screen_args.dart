import 'package:ekorek/model/user/user.dart' as model;

class CreateAppointmentScreenArgs {
  final model.UserTutor tutor;
  final String subject;

  const CreateAppointmentScreenArgs({
    required this.subject,
    required this.tutor,
  });
}