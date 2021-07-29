abstract class CreateDidEvent {}

class FirstNameChanged extends CreateDidEvent {
  FirstNameChanged({required this.firstName});

  final String firstName;
}

class LastNameChanged extends CreateDidEvent {
  LastNameChanged({required this.lastName});

  final String lastName;
}

class DateOfBirthChanged extends CreateDidEvent {
  DateOfBirthChanged({required this.dateOfBirth});

  final DateTime dateOfBirth;
}

class SexChanged extends CreateDidEvent {
  SexChanged({required this.sex});

  final String sex;
}

class AddressChanged extends CreateDidEvent {
  AddressChanged({required this.address});

  final String address;
}

class CityChanged extends CreateDidEvent {
  CityChanged({required this.city});

  final String city;
}

class StateChanged extends CreateDidEvent {
  StateChanged({required this.state});

  final String state;
}

class PostalCodeChanged extends CreateDidEvent {
  PostalCodeChanged({required this.postalCode});

  final String postalCode;
}

class CountryChanged extends CreateDidEvent {
  CountryChanged({required this.country});

  final String country;
}

class Submitted extends CreateDidEvent {}
