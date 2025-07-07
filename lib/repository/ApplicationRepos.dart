import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scholrflutter/services/api_service.dart';
import '../models/postulacion.dart';
import '../utils/preference_manager.dart';

class PostulacionRepository {
  Future<List<Postulacion>> fetchPostulacionesForApoderado(int apoderadoId) async {
    var client = http.Client();
    final token = await PreferenceManager.getToken();

    try {
      final response = await client.get(
          Uri.parse('${ApiService.baseUrl}/applications/apoderado/$apoderadoId'),
          headers: {'Authorization': 'Bearer $token'}
      );

      if (response.statusCode != 200) {
        throw Exception('Error loading postulaciones: ${response.statusCode}');
      }

      final data = jsonDecode(response.body) as List;
      return data.map((json) => Postulacion.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching postulaciones: $e');
    }
  }
}