class CreateStrollParams {
  final String title;
  final String note;
  final DateTime dateTime;
  final int age;
  final String gender;
  final String city;
  final String language;

  CreateStrollParams({
    required this.dateTime,
    required this.title,
    required this.note,
    required this.age,
    required this.city,
    required this.language,
    required this.gender,
  });
}