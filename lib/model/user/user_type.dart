enum UserType {
  TUTOR(name: "TUTOR"),
  STUDENT(name: "STUDENT");

  final String name;
  const UserType({required this.name});

  String get display => this.name;

}