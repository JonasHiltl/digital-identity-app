import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/contact_information/contact_information.dart';

class CreateContactInformationRepo {
  Future<ContactInformation?> createContactInformation(
    String token,
    String email,
    String phoneNumber,
  ) async {
    final _uri = Uri.https("digital-identity-backend.herokuapp.com",
        "/contact-information/create");
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
