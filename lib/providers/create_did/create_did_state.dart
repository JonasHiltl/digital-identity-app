import 'form_submission_status.dart';

class CreateDidState {
  CreateDidState({
    this.firstName = "",
    this.lastName = "",
    this.dateOfBirth,
    this.sex = "",
    this.address = "",
    this.city = "",
    this.state = "",
    this.postalCode = "",
    this.country = "",
    this.formStatus = const InitialFormStatus(),
  });

  final String firstName;
  bool get isValidFirstName => firstName.isNotEmpty;
  final String lastName;
  bool get isValidlastName => lastName.isNotEmpty;
  final DateTime? dateOfBirth;
  bool get isValidDateOfBirth => dateOfBirth is DateTime;
  final String sex;
  bool get isValidSex => sex.isNotEmpty;
  final String address;
  bool get isValidAddress => address.isNotEmpty;
  final String city;
  bool get isValidCity => city.isNotEmpty;
  final String state;
  bool get isValidState => state.isNotEmpty;
  final String postalCode;
  bool get isValidPostalCode => postalCode.isNotEmpty;
  final String country;
  bool get isValidCountry => country.isNotEmpty;
  final FormSubmissionStatus formStatus;

  CreateDidState copyWith({
    String? firstname,
    String? lastName,
    DateTime? dateOfBirth,
    String? sex,
    String? address,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    FormSubmissionStatus? formStatus,
  }) {
    return CreateDidState(
      firstName: firstname ?? firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sex: sex ?? this.sex,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
