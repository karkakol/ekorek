enum UserType {
  TUTOR,
  STUDENT,
}

extension UserTypeExtension on UserType {
  String get display => toString().split('.').last;
}