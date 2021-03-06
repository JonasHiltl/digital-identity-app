import 'dart:convert';

import 'package:digital_identity/db/secure_storage.dart';
import 'package:digital_identity/models/did/did.dart';
import 'package:digital_identity/models/personal_data/personal_data.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils.dart';
import 'create_did.dart';

class CreateDidBloc extends Bloc<CreateDidEvent, CreateDidState> {
  final CreateDidRepository repo;
  final AuthCubit authCubit;
  final SessionBloc sessionBloc;
  final SecureStorage secureStorage = SecureStorage();

  CreateDidBloc({
    required this.repo,
    required this.authCubit,
    required this.sessionBloc,
  }) : super(CreateDidState());

  @override
  Stream<CreateDidState> mapEventToState(CreateDidEvent event) async* {
    if (event is FirstNameChanged) {
      yield state.copyWith(firstname: event.firstName);
    } else if (event is LastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is DateOfBirthChanged) {
      yield state.copyWith(dateOfBirth: event.dateOfBirth);
    } else if (event is SexChanged) {
      yield state.copyWith(sex: event.sex);
    } else if (event is AddressChanged) {
      yield state.copyWith(address: event.address);
    } else if (event is CityChanged) {
      yield state.copyWith(city: event.city);
    } else if (event is StateChanged) {
      yield state.copyWith(state: event.state);
    } else if (event is PostalCodeChanged) {
      yield state.copyWith(postalCode: event.postalCode);
    } else if (event is CountryChanged) {
      yield state.copyWith(country: event.country);
    } else if (event is Submitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      DID? did;
      PersonalData? personalData;
      String? confirmedJwt;

      try {
        final res = await repo.createDid();
        if (res == null) {
          yield state.copyWith(
              formStatus: SubmissionFailed("Backend error creating Did"));
          yield state.copyWith(formStatus: const InitialFormStatus());
        } else {
          await secureStorage.write("did", jsonEncode(res));
          did = res;
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
        yield state.copyWith(formStatus: const InitialFormStatus());
      }

      try {
        final secret = did?.key.secret;
        final public = did?.key.public;
        final token = generateJwt(did!.id, public!, secret!);
        confirmedJwt = await repo.verifyDid(did.id, token);
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed("Backend error creating Did"));
        yield state.copyWith(formStatus: const InitialFormStatus());
      }

      try {
        final res = await repo.createPersonalData(
          confirmedJwt!,
          state.firstName,
          state.lastName,
          state.dateOfBirth,
          state.sex,
          state.address,
          state.city,
          state.state,
          state.postalCode,
          state.country,
        );
        if (res == null) {
          yield state.copyWith(
              formStatus: SubmissionFailed("Backend error creating Did"));
          yield state.copyWith(formStatus: const InitialFormStatus());
        } else {
          await secureStorage.write("personal-data", jsonEncode(res));
          personalData = res;
          yield state.copyWith(formStatus: SubmissionSuccess());
          yield state.copyWith(formStatus: const InitialFormStatus());
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
        yield state.copyWith(formStatus: const InitialFormStatus());
      }

      if (did != null && personalData != null && confirmedJwt != null) {
        authCubit.launchSession(did, personalData, confirmedJwt);
      }
    }
  }
}
