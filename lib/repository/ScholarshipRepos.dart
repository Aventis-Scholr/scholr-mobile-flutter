import 'package:scholrflutter/models/scholarship.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scholrflutter/services/api_service.dart';
import 'package:scholrflutter/utils/preference_manager.dart';

class ScholarshipRepos {

  static Future<List<Scholarship>> fetchScholarshipsFromCompany(String companyName) async {
    var client = http.Client();
    List<Scholarship> scholarships = [];
    final token = await PreferenceManager.getToken();
    try {
      var response = await client.get(
          Uri.parse("${ApiService.baseUrl}/scholarships/company/$companyName"),
          headers: {'Authorization': 'Bearer $token'});
      List result = jsonDecode(response.body);

      print("TEST LISTA");
      print(response.body);

      for (int i = 0; i < result.length; i++) {
        Scholarship s = Scholarship.objJson(result[i] as Map<String, dynamic>);
        scholarships.add(s);
      }
      return scholarships;
    } catch (e) {
      return [];
    }

  }

}