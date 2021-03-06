import 'dart:convert';

import 'package:digital_identity/db/secure_storage.dart';
import 'package:digital_identity/models/contact_information/contact_information.dart';
import 'package:digital_identity/models/did/did.dart';
import 'package:digital_identity/models/personal_data/personal_data.dart';
import 'package:digital_identity/providers/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import '../app_state.dart';
import '../../app_settings/app_settings.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this.repo,
    required this.appSettingsState,
  }) : super(
          SessionState(),
        );

  final SessionRepo repo;
  final AppSettingsState appSettingsState;
  final SecureStorage secureStorage = SecureStorage();
  final _auth = LocalAuthentication();

  Future<bool> hasBiometric() async {
    try {
      final isDeviceSupported = await _auth.isDeviceSupported();
      final isAvailable = await _auth.canCheckBiometrics;
      return isAvailable && isDeviceSupported;
    } on PlatformException catch (e) {
      print("hasBiometric Error $e");
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: "Scan Fingerprint to Authenticate",
        stickyAuth: true,
        androidAuthStrings: const AndroidAuthMessages(
          biometricHint: "",
        ),
      );
    } on PlatformException catch (e) {
      print("Authentication Error: $e");
      return false;
    }
  }

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    if (event is LaunchSession) {
      yield state.copyWith(
        did: event.did,
        personalDataVc: event.personalData,
        jwt: event.jwt,
        sessionStatus: Verified(),
      );
    } else if (event is ChangePersonalData) {
      yield state.copyWith(personalDataVc: event.personalData);
    } else if (event is DeleteAll) {
      await secureStorage.delete("identity");
      await secureStorage.delete("personal-data");
      await secureStorage.delete("contact-information");
      yield state.clear();
    } else if (event is AddContactInformation) {
      yield state.copyWith(contactInformation: event.contactInformation);
    } else if (event is AttemptGettingSavedState) {
      Future<DID> getdid() async {
        final encodedDid = await secureStorage.read("did");
        final decodedDid = jsonDecode(
          encodedDid.toString(),
        ) as Map<String, dynamic>;
        return DID.fromJson(decodedDid);
      }

      Future<PersonalData> getPersonalData() async {
        final encodedPersonalDataVc = await secureStorage.read("personal-data");
        final decodedPersonalDataVc = jsonDecode(
          encodedPersonalDataVc.toString(),
        ) as Map<String, dynamic>;
        return PersonalData.fromJson(decodedPersonalDataVc);
      }

      Future<ContactInformation?> getContactInformation() async {
        if (await secureStorage.contains("contact-information")) {
          final encodedContactinformation =
              await secureStorage.read("contact-information");
          final decodedContactinformation = jsonDecode(
            encodedContactinformation.toString(),
          ) as Map<String, dynamic>;
          return ContactInformation.fromJson(decodedContactinformation);
        } else {
          return null;
        }
      }

      try {
        if (await secureStorage.contains("did") &&
            await secureStorage.contains("personal-data")) {
          final did = await getdid();

          final secret = did.key.secret;
          final public = did.key.public;
          final token = generateJwt(did.id, public, secret);
          final confirmedJwt = await repo.verifyDid(did.id, token);

          final personalDataVc = await getPersonalData();
          final contactInformation = await getContactInformation();

          if (confirmedJwt != null) {
            if (appSettingsState.useTouchID && await hasBiometric()) {
              final isAuthenticated = await authenticate();

              if (isAuthenticated) {
                yield state.copyWith(
                  did: did,
                  personalDataVc: personalDataVc,
                  jwt: confirmedJwt,
                  contactInformation: contactInformation,
                  sessionStatus: Verified(),
                );
              }
            } else {
              yield state.copyWith(
                did: did,
                personalDataVc: personalDataVc,
                contactInformation: contactInformation,
                jwt: confirmedJwt,
                sessionStatus: Verified(),
              );
            }
          } else {
            yield state.copyWith(sessionStatus: Unverified());
          }
        } else {
          yield state.copyWith(sessionStatus: Unverified());
        }
      } catch (e) {
        print("Sessioncubit error: $e");
        yield state.copyWith(
          sessionStatus: Unverified(),
        );
      }
    }
  }
}
