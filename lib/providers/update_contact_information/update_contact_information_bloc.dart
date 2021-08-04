import 'dart:convert';

import 'package:digital_identity/db/secure_storage.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_contact_information.dart';

class UpdateContactInformationBloc
    extends Bloc<UpdateContactInformationEvent, UpdateContactInformationState> {
  UpdateContactInformationBloc({
    required this.repo,
    required this.sessionBloc,
    required this.email,
    required this.phoneNumber,
  }) : super(
          UpdateContactInformationState(email: email, phoneNumber: phoneNumber),
        );

  final UpdateContactInformationRepo repo;
  final SessionBloc sessionBloc;
  final SecureStorage secureStorage = SecureStorage();
  final String email;
  final String phoneNumber;

  @override
  Stream<UpdateContactInformationState> mapEventToState(
      UpdateContactInformationEvent event) async* {
    if (event is ChangeEmail) {
      yield state.copyWith(email: event.email);
    } else if (event is ChangePhoneNumber) {
      yield state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is Submit) {
      yield state.copyWith(formStatus: Submitting());
      try {
        final res = await repo.updateContactInformation(
          sessionBloc.state.jwt,
          state.email,
          state.phoneNumber,
        );
        if (res == null) {
          yield state.copyWith(
              formStatus: SubmissionFailed(
                  "Backend error updating Contact Information"));
          yield state.copyWith(formStatus: const InitialFormStatus());
        } else {
          await secureStorage.write("contact-information", jsonEncode(res));
          yield state.copyWith(formStatus: SubmissionSuccess());
          sessionBloc.add(AddContactInformation(contactInformation: res));
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
        yield state.copyWith(formStatus: const InitialFormStatus());
      }
    }
  }
}
