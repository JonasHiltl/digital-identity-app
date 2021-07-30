import 'dart:convert';
import 'package:digital_identity/models/personal_data/personal_data.dart';
import 'package:http/http.dart' as http;

class UpdatePersonalDataRepo {
  Future<PersonalData?> updatePersonalVc(
    String firstName,
    String lastName,
    DateTime? dateOfBirth,
    String sex,
    String address,
    String city,
    String state,
    String postalCode,
    String country,
  ) async {
    final _uri = Uri.https(
        "digital-identity-backend.herokuapp.com", "/personal-data/update");
    final res = await http.post(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "firstName": firstName.trim(),
        "lastName": lastName.trim(),
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
      final personalDataVcJson = resJson as Map<String, dynamic>;

      return PersonalData.fromJson(personalDataVcJson);
    } else {
      return null;
    }
  }
}
