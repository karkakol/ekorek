import 'package:ekorek/model/user/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@Freezed(unionKey: 'type')
class User with _$User {
  const User._();

  @FreezedUnionValue('STUDENT')
  factory User.student({
    // common
    @Default(UserType.STUDENT) UserType type,
    required String email,
    required String firstName,
    required String lastName,
    required String city,
    required String postalCode,
    required String street,
    required String number,
    // depends on type
    // ...
  }) = UserStudent;

  @FreezedUnionValue('TUTOR')
  factory User.tutor({
    // common
    @Default(UserType.TUTOR) UserType type,
    required String email,
    required String firstName,
    required String lastName,
    required String city,
    required String postalCode,
    required String street,
    required String number,
    // depends on type
    required List<String> subjects,
  }) = UserTutor;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

extension UserExtension on User {
  String get fullName => firstName + " " + lastName;
}

