import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/did/did.dart';
import '../../../models/personal_data/personal_data.dart';

class CreateDidRepository {
  Future<DID?> createDid() async {
    final _uri = Uri.https("did-backend.herokuapp.com", "/did/create");
    final res = await http.get(
      _uri,
    );
    if (res.statusCode == 200) {
      final resJson = jsonDecode(res.body);
      return DID.fromJson(resJson);
    } else {
      print(res.body);
      return null;
    }
  }

  Future<PersonalData?> createPersonalData(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    DateTime? dateOfBirth,
    String sex,
    String address,
    String city,
    String state,
    String postalCode,
    String country,
  ) async {
    final _uri =
        Uri.https("did-backend.herokuapp.com", "/personal-data/create");
    final res = await http.post(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "firstName": firstName.trim(),
        "lastName": lastName.trim(),
        "email": email.trim(),
        "phoneNumber": phoneNumber.trim(),
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "sex": sex.trim(),
        "address": address.trim(),
        "city": city.trim(),
        "state": state.trim(),
        "postalCode": postalCode.trim(),
        "country": country.trim()
      }),
    );
    if (res.statusCode == 200) {
      final resJson = jsonDecode(res.body);
      return PersonalData.fromJson(resJson);
    } else {
      print(res.body);
      return null;
    }
  }
}
