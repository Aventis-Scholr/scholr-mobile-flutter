import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scholrflutter/services/api_service.dart';
import 'package:scholrflutter/utils/preference_manager.dart';

class RechazoRepository {
  Future<void> rechazarPostulacion({
    required int postulacionId,
    required String reporte,
  }) async {
    final token = await PreferenceManager.getToken();
    final client = http.Client();

    try {
      // Actualizar el estado a RECHAZADO
      final statusResponse = await client.put(
        Uri.parse('${ApiService.baseUrl}/applications/$postulacionId/status'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'status': 'RECHAZADO'}),
      );

      if (statusResponse.statusCode != 200) {
        throw Exception('Error al actualizar el estado de la postulación');
      }

      // Actualizar el reporte
      final reporteResponse = await client.put(
        Uri.parse('${ApiService.baseUrl}/applications/$postulacionId/reporte'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'reporte': reporte}),
      );

      if (reporteResponse.statusCode != 200) {
        throw Exception('Error al actualizar el reporte');
      }
    } finally {
      client.close();
    }
  }
}