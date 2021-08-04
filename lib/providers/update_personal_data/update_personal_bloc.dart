import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../db/secure_storage.dart';
import '../../providers/app_state/app_state.dart';
import 'update_personal_data.dart';

class UpdatePersonalBloc
    extends Bloc<UpdatePersonalEvent, UpdatePersonalState> {
  UpdatePersonalBloc({
    required this.repo,
    required this.sessionBloc,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.sex,
    required this.address,
    required this.city,
    required this.locationState,
    required this.postalCode,
    required this.country,
  }) : super(UpdatePersonalState(
          firstName: firstName,
          lastName: lastName,
          dateOfBirth: dateOfBirth,
          sex: sex,
          address: address,
          city: city,
          state: locationState,
          postalCode: postalCode,
          country: country,
        ));

  final UpdatePersonalDataRepo repo;
  final SessionBloc sessionBloc;
  final SecureStorage secureStorage = SecureStorage();

  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String sex;
  final String address;
  final String city;
  final String locationState;
  final String postalCode;
  final String country;

  @override
  Stream<UpdatePersonalState> mapEventToState(
      UpdatePersonalEvent event) async* {
    if (event is UpdateFirstNameChanged) {
      yield state.copyWith(firstname: event.firstName);
    } else if (event is UpdateLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is UpdateDateOfBirthChanged) {
      yield state.copyWith(dateOfBirth: event.dateOfBirth);
    } else if (event is UpdateSexChanged) {
      yield state.copyWith(sex: event.sex);
    } else if (event is UpdateAddressChanged) {
      yield state.copyWith(address: event.address);
    } else if (event is UpdateCityChanged) {
      yield state.copyWith(city: event.city);
    } else if (event is UpdateStateChanged) {
      yield state.copyWith(state: event.state);
    } else if (event is UpdatePostalCodeChanged) {
      yield state.copyWith(postalCode: event.postalCode);
    } else if (event is UpdateCountryChanged) {
      yield state.copyWith(country: event.country);
    } else if (event is UpdateSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final res = await repo.updatePersonalVc(
          sessionBloc.state.jwt,
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
              formStatus: SubmissionFailed("Backend error updating Did"));
          yield state.copyWith(formStatus: const InitialFormStatus());
        } else {
          yield state.copyWith(formStatus: const InitialFormStatus());
          await secureStorage.write("personal-data", jsonEncode(res));

          yield state.copyWith(formStatus: SubmissionSuccess());
          yield state.copyWith(formStatus: const InitialFormStatus());

          // launch the session flow with the returned Did object
          sessionBloc.add(ChangePersonalData(personalData: res));
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e));
        //yield initial state to counter the reappearing of noti after state changes (For example when keyboard gets closed or input changes)
        yield state.copyWith(formStatus: const InitialFormStatus());
      }
    }
  }
}
