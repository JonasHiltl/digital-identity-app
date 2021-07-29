// sessionStatus = similar to a form_status but reflects the states Verified, Unverified, UnkownSessionState
// identity
// personalDataVc
// patientQuestionnaires
// receivedPatientQuestionnaires

import 'package:digital_identity/models/did/did.dart';
import 'package:digital_identity/models/personal_data/personal_data.dart';

import '../app_state.dart';

class SessionState {
  SessionState({
    this.identity,
    this.personalDataVc,
    this.sessionStatus = const UnkownSessionStatus(),
  });

  final DID? identity;
  final PersonalData? personalDataVc;
  final SessionStatus sessionStatus;

  SessionState clear() => SessionState(
        sessionStatus: Unverified(),
      );

  SessionState copyWith({
    DID? identity,
    PersonalData? personalDataVc,
    SessionStatus? sessionStatus,
  }) {
    return SessionState(
      identity: identity ?? this.identity,
      personalDataVc: personalDataVc ?? this.personalDataVc,
      sessionStatus: sessionStatus ?? this.sessionStatus,
    );
  }
}
