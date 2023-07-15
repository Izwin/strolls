class UserEntity {
  String id;
  String name;
  String surname;
  String username;
  String birthdate;
  String city;
  String gender;
  int age;
  List<String> languages;
  List<UserEntity> friends;
  int likeCount;
  int strollCount;
  String bio;
  String avatarUrl;

  UserEntity({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.city,
    required this.age,
    required this.bio,
    required this.birthdate,
    required this.friends,
    required this.gender,
    required this.languages,
    required this.likeCount,
    required this.strollCount,
    required this.avatarUrl
  });
}
