import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/models/auth/change_password_model.dart';
import 'package:proyecto_final/modules/auth/pages/login.dart';
import 'package:proyecto_final/providers/auth_providers.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  final String token;

  const ChangePasswordScreen({
    required this.token,
    super.key,
  });

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _claveAnteriorController =
      TextEditingController();
  final TextEditingController _claveNuevaController = TextEditingController();
  final TextEditingController _confirmarClaveController =
      TextEditingController();

  bool _isObscureOldPassword = true;
  bool _isObscureNewPassword = true;
  bool _isObscureConfirmPassword = true;
  bool _isLoading = false;

  Future<void> changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final forgotterModel = ChangePasswordModel(
          token: widget.token,
          claveAnterior: _claveAnteriorController.text,
          claveNueva: _claveNuevaController.text,
        );

        final response =
            await ref.watch(changePasswordProvider(forgotterModel).future);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.mensaje),
            backgroundColor: Colors.green,
          ),
        );

        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('¡Contraseña actualizada con éxito!'),
              backgroundColor: Colors.green,
            ),
          );

          // Navegar al login después de cambiar la contraseña
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al cambiar la contraseña: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cambiar Contraseña',
          style: TextStyle(
            color: Colors.orange.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icono o logo
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_open,
                        size: 50,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Título
                  Text(
                    'Establece tu nueva contraseña',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Descripción
                  Text(
                    'Ingresa tu contraseña actual y tu nueva contraseña para actualizarla.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Token (solo para mostrar, normalmente no se mostraría)

                  // Contraseña anterior
                  TextFormField(
                    controller: _claveAnteriorController,
                    obscureText: _isObscureOldPassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña actual',
                      labelStyle: TextStyle(color: Colors.orange.shade800),
                      prefixIcon: Icon(Icons.lock_outline,
                          color: Colors.orange.shade600),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscureOldPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.orange.shade600,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscureOldPassword = !_isObscureOldPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.orange.shade600, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                      filled: true,
                      fillColor: Colors.orange.shade50,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu contraseña actual';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Nueva contraseña
                  TextFormField(
                    controller: _claveNuevaController,
                    obscureText: _isObscureNewPassword,
                    decoration: InputDecoration(
                      labelText: 'Nueva contraseña',
                      labelStyle: TextStyle(color: Colors.orange.shade800),
                      prefixIcon:
                          Icon(Icons.lock, color: Colors.orange.shade600),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscureNewPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.orange.shade600,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscureNewPassword = !_isObscureNewPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.orange.shade600, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                      filled: true,
                      fillColor: Colors.orange.shade50,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa una nueva contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirmar contraseña
                  TextFormField(
                    controller: _confirmarClaveController,
                    obscureText: _isObscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirmar nueva contraseña',
                      labelStyle: TextStyle(color: Colors.orange.shade800),
                      prefixIcon:
                          Icon(Icons.lock_clock, color: Colors.orange.shade600),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.orange.shade600,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscureConfirmPassword =
                                !_isObscureConfirmPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.orange.shade600, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                      filled: true,
                      fillColor: Colors.orange.shade50,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor confirma tu nueva contraseña';
                      }
                      if (value != _claveNuevaController.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),

                  // Botón de cambiar contraseña
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : changePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade800,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.orange.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'CAMBIAR CONTRASEÑA',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Cancelar / Volver
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Colors.orange.shade800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _claveAnteriorController.dispose();
    _claveNuevaController.dispose();
    _confirmarClaveController.dispose();
    super.dispose();
  }
}
