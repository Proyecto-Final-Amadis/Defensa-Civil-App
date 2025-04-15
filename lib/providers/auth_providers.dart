import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/models/login_model.dart';
import 'package:proyecto_final/services/auth_services.dart';

final loginServiceProvider = Provider<AuthServices>((ref) => AuthServices());

final loginProvider = FutureProvider<LoginResponse>((ref) async {
  final loginService = ref.read(loginServiceProvider);
  return await loginService.login();
});
