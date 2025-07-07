import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scholrflutter/services/api_service.dart';
import 'package:scholrflutter/utils/preference_manager.dart';

class AcceptanceRepository {
  Future<void> acceptApplication(int postulacionId) async {
    final token = await PreferenceManager.getToken();
    final client = http.Client();

    try {
      final response = await client.put(
        Uri.parse('${ApiService.baseUrl}/applications/$postulacionId/status'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'status': 'APROBADO'}),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al aceptar la postulación');
      }
    } finally {
      client.close();
    }
  }
}