import 'dart:convert';

import 'package:digital_identity/db/secure_storage.dart';
import 'package:digital_identity/models/did/did.dart';
import 'package:digital_identity/models/personal_data/personal_data.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_did.dart';

class CreateDidBloc extends Bloc<CreateDidEvent, CreateDidState> {
  final CreateDidRepository repo;
  final AuthCubit authCubit;
  final SecureStorage secureStorage = SecureStorage();

  CreateDidBloc({
    required this.repo,
    required this.authCubit,
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
      String? id;

      try {
        final res = await repo.createDid();
        if (res == null) {
          yield state.copyWith(
              formStatus: SubmissionFailed("Backend error creating Did"));
          yield state.copyWith(formStatus: const InitialFormStatus());
        } else {
          await secureStorage.write("did", jsonEncode(res));
          id = res.id;
          did = res;
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
        yield state.copyWith(formStatus: const InitialFormStatus());
      }
      try {
        final res = await repo.createPersonalData(
          id!,
          state.firstName,
          state.lastName,
          state.email,
          state.phoneNumber,
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
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
        yield state.copyWith(formStatus: const InitialFormStatus());
      }

      if (did != null && personalData != null) {
        authCubit.launchSession(did, personalData);
      }
    }
  }
}
