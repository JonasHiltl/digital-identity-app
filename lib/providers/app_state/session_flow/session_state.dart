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
    this.did,
    this.personalDataVc,
    this.sessionStatus = const UnkownSessionStatus(),
  });

  final DID? did;
  final PersonalData? personalDataVc;
  final SessionStatus sessionStatus;

  SessionState clear() => SessionState(
        sessionStatus: Unverified(),
      );

  SessionState copyWith({
    DID? did,
    PersonalData? personalDataVc,
    SessionStatus? sessionStatus,
  }) {
    return SessionState(
      did: did ?? this.did,
      personalDataVc: personalDataVc ?? this.personalDataVc,
      sessionStatus: sessionStatus ?? this.sessionStatus,
    );
  }
}
