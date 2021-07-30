import 'package:digital_identity/models/did/did.dart';
import 'package:digital_identity/models/personal_data/personal_data.dart';

abstract class SessionEvent {}

class AttemptGettingSavedState extends SessionEvent {}

class ChangePersonalData extends SessionEvent {
  final PersonalData personalData;

  ChangePersonalData({required this.personalData});
}

class LaunchSession extends SessionEvent {
  final DID did;
  final PersonalData personalData;

  LaunchSession({
    required this.did,
    required this.personalData,
  });
}
