import 'package:ekorek/model/user/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  factory User.student({
    // common
    required UserType type,
    required String email,
    required String firstName,
    required String lastName,
    // depends on type
    // ...
  }) = UserStudent;

  factory User.tutor({
    // common
    required UserType type,
    required String email,
    required String firstName,
    required String lastName,
    // depends on type
    required List<String> subjects,
  }) = UserTutor;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static User setup({required UserType type, required String email, required String firstName, required String lastName}) {
    switch (type) {
      case UserType.TUTOR:
        return User.tutor(type: type, firstName: firstName, lastName: lastName, email: email, subjects: []);
      case UserType.STUDENT:
        return User.student(type: type, firstName: firstName, lastName: lastName, email: email);
    }
  }
}

