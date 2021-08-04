import 'form_submission_status.dart';

final RegExp _emailRegExp = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

class CreateContactInformationState {
  CreateContactInformationState({
    this.email = "",
    this.phoneNumber = "",
    this.formStatus = const InitialFormStatus(),
  });

  final String email;
  bool get isValidEmail => email.isNotEmpty && _emailRegExp.hasMatch(email);
  bool get showEmailError => email.isNotEmpty && !_emailRegExp.hasMatch(email);
  final String phoneNumber;
  bool get isValidPhoneNumber => phoneNumber.isNotEmpty;
  final FormSubmissionStatus formStatus;

  CreateContactInformationState copyWith({
    String? email,
    String? phoneNumber,
    FormSubmissionStatus? formStatus,
  }) {
    return CreateContactInformationState(
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
