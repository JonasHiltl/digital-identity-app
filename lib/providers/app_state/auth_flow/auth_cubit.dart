import 'package:digital_identity/models/did/did.dart';
import 'package:digital_identity/models/personal_data/personal_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_state.dart';

enum AuthState { introduction, creation }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.sessionBloc,
  ) : super(
          AuthState.introduction,
        );
  final SessionBloc sessionBloc;

  void showIntroduction() => emit(AuthState.introduction);
  void showCreation() => emit(AuthState.creation);

  void launchSession(DID identity, PersonalData personalData) =>
      sessionBloc.add(LaunchSession(did: identity, personalData: personalData));
}
