import 'dart:convert';

import 'package:digital_identity/db/secure_storage.dart';
import 'package:digital_identity/providers/app_state/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_contact_information.dart';

class CreateContactInformationBloc
    extends Bloc<CreateContactInformationEvent, CreateContactInformationState> {
  CreateContactInformationBloc({
    required this.repo,
    required this.sessionBloc,
    required this.authCubit,
  }) : super(CreateContactInformationState());

  final CreateContactInformationRepo repo;
  final SessionBloc sessionBloc;
  final AuthCubit authCubit;
  final SecureStorage secureStorage = SecureStorage();

  @override
  Stream<CreateContactInformationState> mapEventToState(
      CreateContactInformationEvent event) async* {
    if (event is ChangeEmail) {
      yield state.copyWith(email: event.email);
    } else if (event is ChangePhoneNumer) {
      yield state.copyWith(phoneNumber: event.phoneNumber);
    } else if (event is Submitted) {
      yield state.copyWith(formStatus: Submitting());

      try {
        final res = await repo.createContactInformation(
          sessionBloc.state.jwt,
          state.email,
          state.phoneNumber,
        );
        if (res == null) {
          yield state.copyWith(
              formStatus:
                  SubmissionFailed("Backend error adding contact information"));
          yield state.copyWith(formStatus: const InitialFormStatus());
        } else {
          await secureStorage.write("contact-information", jsonEncode(res));
          yield state.copyWith(formStatus: SubmissionSuccess());
          sessionBloc.add(AddContactInformation(contactInformation: res));
        }
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
        yield state.copyWith(formStatus: const InitialFormStatus());
      }
    }
  }
}
