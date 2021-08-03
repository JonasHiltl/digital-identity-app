// sessionStatus = similar to a form_status but reflects the states Verified, Unverified, UnkownSessionState
// identity
// personalDataVc
// patientQuestionnaires
// receivedPatientQuestionnaires

import 'package:digital_identity/models/contact_information/contact_information.dart';
import 'package:digital_identity/models/did/did.dart';
import 'package:digital_identity/models/personal_data/personal_data.dart';

import '../app_state.dart';

class SessionState {
  SessionState({
    this.did,
    this.personalDataVc,
    this.contactInformation,
    this.jwt = "",
    this.sessionStatus = const UnkownSessionStatus(),
  });

  final DID? did;
  final PersonalData? personalDataVc;
  final ContactInformation? contactInformation;
  final String jwt;
  final SessionStatus sessionStatus;

  SessionState clear() => SessionState(
        sessionStatus: Unverified(),
      );

  SessionState copyWith({
    DID? did,
    PersonalData? personalDataVc,
    ContactInformation? contactInformation,
    String? jwt,
    SessionStatus? sessionStatus,
  }) {
    return SessionState(
      did: did ?? this.did,
      personalDataVc: personalDataVc ?? this.personalDataVc,
      contactInformation: contactInformation ?? this.contactInformation,
      jwt: jwt ?? this.jwt,
      sessionStatus: sessionStatus ?? this.sessionStatus,
    );
  }
}
