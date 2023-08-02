abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class GotCitiesState extends RegistrationState{
  final List<String> cities;

  GotCitiesState({required this.cities});
}

class GotLanguagesState extends RegistrationState{
  final List<String> languages;

  GotLanguagesState({required this.languages});
}

class RegistrationError extends RegistrationState{
  final String errorMessage;
  RegistrationError({required this.errorMessage});
}

class RegistrationLoading extends RegistrationState{}

class RegistrationSuccess extends RegistrationState{}