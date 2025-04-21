// api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/config/preferences.dart';
import 'package:proyecto_final/models/albergue.dart';
import 'package:proyecto_final/models/medidads.dart';
import 'package:proyecto_final/models/situacion.dart';

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

  // Reportar situación
  Future<GeneralResponse> reportarSituacion(SituacionModel situacion) async {
    try {
      final token = await AppPreferences.getStringPreference('token');

      // Crear el mapa de datos para enviar
      final Map<String, dynamic> data = {
        'token': token,
        ...situacion.toJson(),
      };

      final response = await clientDio.post(
        '/reportar_situacion.php',
        data: FormData.fromMap(data),
      );

      final GeneralResponse respuestaData =
          GeneralResponse.fromJson(response.data);
      return respuestaData;
    } catch (e) {
      debugPrint('Error al reportar situación: $e');
      rethrow;
    }
  }

  // Obtener situaciones del usuario
  Future<SituacionesResponse> getMisSituaciones() async {
    try {
      final token = await AppPreferences.getStringPreference('token');

      final response = await clientDio.get(
        '/mis_situaciones.php',
        queryParameters: {'token': token},
      );

      final SituacionesResponse data =
          SituacionesResponse.fromJson(response.data);
      return data;
    } catch (e) {
      debugPrint('Error al obtener mis situaciones: $e');
      rethrow;
    }
  }
}
