import './update_contact_information.dart';

class UpdateContactInformationState {
  UpdateContactInformationState({
    required this.email,
    required this.phoneNumber,
    this.formStatus = const InitialFormStatus(),
  });

  final String email;
  bool get isValidEmail => email.isNotEmpty;
  final String phoneNumber;
  bool get isValidPhoneNumber => phoneNumber.isNotEmpty;
  bool get oneIsInvalid => email.isEmpty || phoneNumber.isEmpty;
  final FormSubmissionStatus formStatus;

  UpdateContactInformationState copyWith({
    String? email,
    String? phoneNumber,
    FormSubmissionStatus? formStatus,
  }) {
    return UpdateContactInformationState(
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
