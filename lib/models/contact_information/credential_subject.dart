import 'package:json_annotation/json_annotation.dart';

part 'credential_subject.g.dart';

@JsonSerializable()
class CredentialSubject {
  CredentialSubject({
    required this.email,
    required this.phoneNumber,
  });

  final String email;
  final String phoneNumber;

  factory CredentialSubject.fromJson(Map<String, dynamic> data) =>
      _$CredentialSubjectFromJson(data);

  Map<String, dynamic> toJson() => _$CredentialSubjectToJson(this);
}
