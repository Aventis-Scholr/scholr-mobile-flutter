import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:scholrflutter/services/api_service.dart';
import '../models/apoderado.dart';
import '../utils/preference_manager.dart';

class ApoderadoRepository {

  Future<List<Apoderado>> fetchApoderadosForScholarship(int scholarshipId) async {
    var client = http.Client();
    final token = await PreferenceManager.getToken();
    final response = await client.get(
      Uri.parse('${ApiService.baseUrl}/users/apoderados/scholarships/$scholarshipId/pendingApplication'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != 200) {
      throw Exception('Error loading apoderados');
    }

    final data = jsonDecode(response.body) as List;
    return data.map((json) => Apoderado.objJson(json)).toList();
  }

  Future<DataApoderado> fetchDataApoderado(int id) async {
    var client = http.Client();
    final token = await PreferenceManager.getToken();
    final response = await client.get(
      Uri.parse('${ApiService.baseUrl}/data-apoderado/apoderado/$id'),
        headers: {'Authorization': 'Bearer $token'}
    );

    if (response.statusCode != 200) {
      throw Exception('Error loading Data Apoderado');
    }

    final dataMap = jsonDecode(response.body);
    final data = DataApoderado.fromJson(dataMap);
    return data;
  }
}
