// api_service.dart
import 'package:flutter/foundation.dart';
import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/albergue.dart';
import 'package:proyecto_final/models/medidads.dart';

class ApiService extends ClientBase {
  // Albergues
  Future<AlberguesResponse> getAlbergues() async {
    try {
      final response = await clientDio.get('/albergues.php');
      final AlberguesResponse data = AlberguesResponse.fromJson(response.data);
      return data;
    } catch (e) {
      debugPrint('Error al obtener albergues: $e');
      rethrow;
    }
  }

  // Medidas Preventivas
  Future<MedidasPreventivasResponse> getMedidasPreventivas() async {
    try {
      final response = await clientDio.get('/medidas_preventivas.php');
      final MedidasPreventivasResponse data =
          MedidasPreventivasResponse.fromJson(response.data);
      return data;
    } catch (e) {
      debugPrint('Error al obtener medidas preventivas: $e');
      rethrow;
    }
  }
}
