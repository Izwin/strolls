import '../../data/models/send_registration_params_model.dart';

abstract class RegistrationEvent {}

class GetCitiesEvent extends RegistrationEvent {}

class GetLanguagesEvent extends RegistrationEvent {}

