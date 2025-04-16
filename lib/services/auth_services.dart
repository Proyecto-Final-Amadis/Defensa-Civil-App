import 'package:flutter/widgets.dart';
import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/general_response.dart';
import 'package:proyecto_final/models/login_model.dart';
import 'package:proyecto_final/models/register_model.dart';

class AuthServices extends ClientBase {
  Future<GeneralResponse> login(LoginModel body) async {
    final response =
        await clientDio.post('/iniciar_sesion.php', data: body.toJson());
    final GeneralResponse data = GeneralResponse.fromJson(response.data);
    return data;
  }

  Future<GeneralResponse> register(RegisterModel body) async {
    try {
      // print(body.toJson());
      final response =
          await clientDio.post('/registro.php', data: body.toJson());

      final GeneralResponse data = GeneralResponse.fromJson(response.data);
      return data;
    } catch (e) {
      debugPrint('Error en el registro: $e');
      rethrow;
    }
  }
}
