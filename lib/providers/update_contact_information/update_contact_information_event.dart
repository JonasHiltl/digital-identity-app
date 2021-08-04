abstract class UpdateContactInformationEvent {}

class ChangeEmail extends UpdateContactInformationEvent {
  ChangeEmail({required this.email});

  final String email;
}

class ChangePhoneNumber extends UpdateContactInformationEvent {
  ChangePhoneNumber({required this.phoneNumber});

  final String phoneNumber;
}

class Submit extends UpdateContactInformationEvent {}
