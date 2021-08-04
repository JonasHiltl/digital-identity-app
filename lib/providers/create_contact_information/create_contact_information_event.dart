abstract class CreateContactInformationEvent {}

class ChangeEmail extends CreateContactInformationEvent {
  ChangeEmail({required this.email});

  final String email;
}

class ChangePhoneNumer extends CreateContactInformationEvent {
  ChangePhoneNumer({required this.phoneNumber});

  final String phoneNumber;
}

class Submitted extends CreateContactInformationEvent {}
