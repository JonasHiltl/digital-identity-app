abstract class UpdatePersonalEvent {}

class UpdateFirstNameChanged extends UpdatePersonalEvent {
  UpdateFirstNameChanged({required this.firstName});

  final String firstName;
}

class UpdateLastNameChanged extends UpdatePersonalEvent {
  UpdateLastNameChanged({required this.lastName});

  final String lastName;
}

class UpdateDateOfBirthChanged extends UpdatePersonalEvent {
  UpdateDateOfBirthChanged({required this.dateOfBirth});

  final DateTime dateOfBirth;
}

class UpdateSexChanged extends UpdatePersonalEvent {
  UpdateSexChanged({required this.sex});

  final String sex;
}

class UpdateAddressChanged extends UpdatePersonalEvent {
  UpdateAddressChanged({required this.address});

  final String address;
}

class UpdateCityChanged extends UpdatePersonalEvent {
  UpdateCityChanged({required this.city});

  final String city;
}

class UpdateStateChanged extends UpdatePersonalEvent {
  UpdateStateChanged({required this.state});

  final String state;
}

class UpdatePostalCodeChanged extends UpdatePersonalEvent {
  UpdatePostalCodeChanged({required this.postalCode});

  final String postalCode;
}

class UpdateCountryChanged extends UpdatePersonalEvent {
  UpdateCountryChanged({required this.country});

  final String country;
}

class UpdateSubmitted extends UpdatePersonalEvent {}
