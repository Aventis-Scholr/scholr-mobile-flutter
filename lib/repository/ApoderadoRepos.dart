import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scholrflutter/services/api_service.dart';
import '../models/apoderado.dart';
import '../utils/preference_manager.dart';

class ApoderadoRepository {
  final http.Client httpClient;

  ApoderadoRepository({required this.httpClient});

  Future<List<Apoderado>> fetchApoderadosForScholarship(int scholarshipId) async {
    final token = await PreferenceManager.getToken();
    final response = await httpClient.get(
      Uri.parse('${ApiService.baseUrl}/users/apoderados/scholarships/$scholarshipId/pendingApplication'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != 200) {
      throw Exception('Error loading apoderados');
    }

    final data = jsonDecode(response.body) as List;
    return data.map((json) => Apoderado.objJson(json)).toList();
  }
}
