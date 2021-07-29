import 'dart:convert';
import 'package:http/http.dart' as http;

class SessionRepo {
  Future<bool> verifyDid(String id) async {
    final _uri =
        Uri.https("digital-identity-backend.herokuapp.com", "/did/verify");
    final res = await http.post(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"id": id}),
    );
    if (res.statusCode == 200) {
      return true;
    }
    print(res.body);
    return false;
  }
}
