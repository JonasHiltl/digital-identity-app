import 'package:digital_identity/models/contact_information/contact_information.dart';
import 'package:digital_identity/models/did/did.dart';
import 'package:digital_identity/models/personal_data/personal_data.dart';

abstract class SessionEvent {}

class AttemptGettingSavedState extends SessionEvent {}

class ChangePersonalData extends SessionEvent {
  final PersonalData personalData;

  ChangePersonalData({required this.personalData});
}

class AddContactInformation extends SessionEvent {
  final ContactInformation contactInformation;

  AddContactInformation({required this.contactInformation});
}

class LaunchSession extends SessionEvent {
  final DID did;
  final PersonalData personalData;
  final String jwt;

  LaunchSession({
    required this.did,
    required this.personalData,
    required this.jwt,
  });
}
