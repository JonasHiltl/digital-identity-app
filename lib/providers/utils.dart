import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:fast_base58/fast_base58.dart';

String generateJwt(String subject, String public, String secret) {
  final decodedSecret = Base58Decode(secret);
  final decodedPublic = Base58Decode(public);
  /* [208, 105, 206, 135, 43, 101, 101, 250, 227, 140, 174, 15, 170, 99, 69, 156,
   193, 74, 234, 158, 136, 83, 124, 133, 190, 248, 205, 196, 217, 126, 164, 196] */

  final List<int> joinedPrivat = new List.from(decodedSecret)
    ..addAll(decodedPublic);

  // Create a json web token
  final jwt = JWT(
    {
      'subject': subject,
    },
    issuer: subject,
  );

  final key = EdDSAPrivateKey(joinedPrivat);

  final token = jwt.sign(key, algorithm: JWTAlgorithm.EdDSA);
  return token;
}
