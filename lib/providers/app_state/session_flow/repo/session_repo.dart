import 'dart:convert';

import 'package:http/http.dart' as http;

class SessionRepo {
  Future<String?> verifyDid(String id, String token) async {
    final _uri =
        Uri.https("digital-identity-backend.herokuapp.com", "/did/verify");
    final res = await http.get(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      },
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    return null;
  }
}
