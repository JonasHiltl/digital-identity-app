import 'dart:convert';

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
          identity: event.identity,
          personalDataVc: event.personalData,
          sessionStatus: Verified());
    } else if (event is AttemptGettingSavedState) {
      yield state.copyWith(
        sessionStatus: Unverified(),
      );
    }
  }
}
