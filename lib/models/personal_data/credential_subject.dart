import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'credential_subject.g.dart';

@JsonSerializable(explicitToJson: true)
class CredentialSubject {
  CredentialSubject({
    required this.address,
    required this.dateOfBirth,
    required this.firstName,
    required this.lastName,
    required this.sex,
  });

  final String firstName;
  final String lastName;
  final String sex;
  final DateTime dateOfBirth;
  final Address address;

  factory CredentialSubject.fromJson(Map<String, dynamic> data) =>
      _$CredentialSubjectFromJson(data);

  Map<String, dynamic> toJson() => _$CredentialSubjectToJson(this);
}
