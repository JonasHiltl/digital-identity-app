import 'dart:convert';

import 'package:digital_identity/models/contact_information/contact_information.dart';
import "package:http/http.dart" as http;

class UpdateContactInformationRepo {
  Future<ContactInformation?> updateContactInformation(
    String token,
    String email,
    String phoneNumber,
  ) async {
    print(
      jsonEncode({
        "email": email.trim(),
        "phoneNumber": phoneNumber.trim(),
      }),
    );
    final _uri = Uri.https("digital-identity-backend.herokuapp.com",
        "/contact-information/update");
    final res = await http.post(
      _uri,
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "email": email.trim(),
        "phoneNumber": phoneNumber.trim(),
      }),
    );
    if (res.statusCode == 200) {
      final resJson = jsonDecode(res.body);
      return ContactInformation.fromJson(resJson);
    } else {
      print(res.body);
      return null;
    }
  }
}
