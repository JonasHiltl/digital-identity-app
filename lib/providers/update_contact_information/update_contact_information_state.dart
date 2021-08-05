import './update_contact_information.dart';

final RegExp _emailRegExp = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

class UpdateContactInformationState {
  UpdateContactInformationState({
    required this.email,
    required this.phoneNumber,
    this.formStatus = const InitialFormStatus(),
  });

  final String email;
  bool get isValidEmail => email.isNotEmpty && _emailRegExp.hasMatch(email);
  final String phoneNumber;
  bool get isValidPhoneNumber => phoneNumber.isNotEmpty;
  bool get oneIsInvalid =>
      email.isEmpty || phoneNumber.isEmpty || !_emailRegExp.hasMatch(email);
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
