import 'package:json_annotation/json_annotation.dart';

import 'key.dart';

part 'did.g.dart';

@JsonSerializable(explicitToJson: true)
class DID {
  DID({
    required this.id,
    required this.created,
    required this.key,
    required this.messageId,
  });
  final String id;
  final String created;
  final Key key;
  final String messageId;

  factory DID.fromJson(Map<String, dynamic> data) => _$DIDFromJson(data);

  Map<String, dynamic> toJson() => _$DIDToJson(this);
}
