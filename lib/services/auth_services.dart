import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/login_model.dart';

class AuthServices extends ClientBase {
  Future<LoginResponse> login() async {
    final response = await clientDio.post('/iniciar_sesion.php');
    final LoginResponse data = LoginResponse.fromJson(response.data);
    return data;
  }
}
