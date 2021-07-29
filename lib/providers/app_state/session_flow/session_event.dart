import 'package:digital_identity/models/did/did.dart';
import 'package:digital_identity/models/personal_data/personal_data.dart';

abstract class SessionEvent {}

class AttemptGettingSavedState extends SessionEvent {}

class LaunchSession extends SessionEvent {
  final DID identity;
  final PersonalData personalData;

  LaunchSession({
    required this.identity,
    required this.personalData,
  });
}
