import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/models/general_response.dart';
import 'package:proyecto_final/models/login_model.dart';
import 'package:proyecto_final/models/register_model.dart';
import 'package:proyecto_final/services/auth_services.dart';

final authServiceProvider = Provider<AuthServices>((ref) => AuthServices());

final registerProvider =
    FutureProvider.family<GeneralResponse, RegisterModel>((ref, body) async {
  final registerService = ref.read(authServiceProvider);
  return await registerService.register(body);
});

final loginProvider =
    FutureProvider.family<GeneralResponse, LoginModel>((ref, body) async {
  final loginService = ref.read(authServiceProvider);
  return await loginService.login(body);
});
