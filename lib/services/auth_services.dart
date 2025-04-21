import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/auth/change_password_model.dart';
import 'package:proyecto_final/models/auth/forgotten_model.dart';
import 'package:proyecto_final/models/general_response.dart';
import 'package:proyecto_final/models/auth/login_model.dart';
import 'package:proyecto_final/models/auth/register_model.dart';

class AuthServices extends ClientBase {
  Future<GeneralResponse> login(LoginModel body) async {
    final formData = FormData.fromMap(body.toJson());
    final response =
        await clientDio.post('/iniciar_sesion.php', data: formData);
    final GeneralResponse data = GeneralResponse.fromJson(response.data);
    return data;
  }

  Future<GeneralResponse> register(RegisterModel body) async {
    try {
      final formData = FormData.fromMap(body.toJson());

      final response = await clientDio.post('/registro.php', data: formData);

      final GeneralResponse data = GeneralResponse.fromJson(response.data);
      return data;
    } catch (e) {
      debugPrint('Error en el registro: $e');
      rethrow;
    }
  }

  Future<GeneralResponse> recoverPassword(ForgottenModel body) async {
    try {
      final formData = FormData.fromMap(body.toJson());

      final response =
          await clientDio.post('/recuperar_clave.php', data: formData);

      final GeneralResponse data = GeneralResponse.fromJson(response.data);
      return data;
    } catch (e) {
      debugPrint('Error en la recuperación de contraseña: $e');
      rethrow;
    }
  }

  Future<GeneralResponse> changePassword(ChangePasswordModel body) async {
    try {
      final formData = FormData.fromMap(body.toJson());

      final response =
          await clientDio.post('/cambiar_clave.php', data: formData);

      final GeneralResponse data = GeneralResponse.fromJson(response.data);
      return data;
    } catch (e) {
      debugPrint('Error en la modificación de contraseña: $e');
      rethrow;
    }
  }
}
