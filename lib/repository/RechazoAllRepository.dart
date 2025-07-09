import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scholrflutter/services/api_service.dart';
import 'package:scholrflutter/utils/preference_manager.dart';

class RechazoAllRepository {
  Future<void> rechazarAllPostulaciones({
    required int apoderadoId,
    required String reporte,
  }) async {
    final token = await PreferenceManager.getToken();
    final client = http.Client();

    try {
      final response = await client.put(
        Uri.parse('${ApiService.baseUrl}/applications/rejectAllApplicationsByApoderadoId/$apoderadoId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'reporte': reporte}),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al rechazar todas las postulaciones');
      }
    } finally {
      client.close();
    }
  }
}