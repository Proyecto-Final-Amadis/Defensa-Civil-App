// reportar_situacion_page.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyecto_final/models/situacion.dart';
import 'package:proyecto_final/providers/someproviders.dart';

class ReportarSituacionPage extends ConsumerStatefulWidget {
  const ReportarSituacionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ReportarSituacionPage> createState() =>
      _ReportarSituacionPageState();
}

class _ReportarSituacionPageState extends ConsumerState<ReportarSituacionPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  File? _imagen;
  String _latitud = '';
  String _longitud = '';
  bool _cargando = false;
  bool _obteniendoUbicacion = false;

  @override
  void initState() {
    super.initState();
    _solicitarPermisos();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _solicitarPermisos() async {
    final locationStatus = await Permission.location.request();
    final cameraStatus = await Permission.camera.request();

    if (locationStatus.isGranted) {
      _obtenerUbicacion();
    }

    if (!cameraStatus.isGranted) {
      // Mostrar mensaje si no se otorgan permisos de cámara
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Se requiere permiso de cámara para tomar fotos')),
        );
      }
    }
  }

  Future<void> _obtenerUbicacion() async {
    setState(() {
      _obteniendoUbicacion = true;
    });

    try {
      final posicion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _latitud = posicion.latitude.toString();
        _longitud = posicion.longitude.toString();
        _obteniendoUbicacion = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al obtener la ubicación')),
        );
      }
      setState(() {
        _obteniendoUbicacion = false;
      });
    }
  }

  Future<void> _tomarFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagen = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800, // Reducir el tamaño para optimizar
      imageQuality: 85, // Calidad al 85% para reducir el tamaño del archivo
    );

    if (imagen != null) {
      setState(() {
        _imagen = File(imagen.path);
      });
    }
  }

  Future<void> _seleccionarFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagen = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );

    if (imagen != null) {
      setState(() {
        _imagen = File(imagen.path);
      });
    }
  }

  Future<void> _enviarReporte() async {
    if (_formKey.currentState!.validate()) {
      if (_imagen == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Debes agregar una imagen')),
        );
        return;
      }

      if (_latitud.isEmpty || _longitud.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se ha podido obtener tu ubicación')),
        );
        return;
      }

      setState(() {
        _cargando = true;
      });

      try {
        // Convertir la imagen a base64
        final bytes = await _imagen!.readAsBytes();
        final String fotoBase64 = base64Encode(bytes);

        // Crear objeto de situación
        final situacion = SituacionModel(
          titulo: _tituloController.text,
          descripcion: _descripcionController.text,
          foto: fotoBase64,
          latitud: _latitud,
          longitud: _longitud,
        );

        // Enviar el reporte
        final resultado =
            await ref.read(reportarSituacionProvider(situacion).future);

        if (mounted) {
          if (resultado.exito) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(resultado.mensaje)),
            );
            Navigator.pop(context); // Regresar a la pantalla anterior
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${resultado.mensaje}')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al enviar el reporte: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _cargando = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Situación'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Título
                    TextFormField(
                      controller: _tituloController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un título';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Descripción
                    TextFormField(
                      controller: _descripcionController,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa una descripción';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Foto
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _imagen == null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image, size: 50),
                                  const SizedBox(height: 16),
                                  const Text('No hay imagen seleccionada'),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: _tomarFoto,
                                        icon: const Icon(Icons.camera_alt),
                                        label: const Text('Cámara'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.orange.shade800,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      ElevatedButton.icon(
                                        onPressed: _seleccionarFoto,
                                        icon: const Icon(Icons.photo_library),
                                        label: const Text('Galería'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.orange.shade800,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.file(
                                  _imagen!,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          _imagen = null;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 16),

                    // Ubicación
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.orange.shade800),
                                const SizedBox(width: 8),
                                const Text(
                                  'Ubicación',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            _obteniendoUbicacion
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(_latitud.isEmpty || _longitud.isEmpty
                                          ? 'No se ha podido obtener tu ubicación'
                                          : 'Latitud: $_latitud\nLongitud: $_longitud'),
                                      const SizedBox(height: 8),
                                      ElevatedButton.icon(
                                        onPressed: _obtenerUbicacion,
                                        icon: const Icon(Icons.refresh),
                                        label:
                                            const Text('Actualizar ubicación'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.orange.shade800,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Botón enviar
                    ElevatedButton(
                      onPressed: _enviarReporte,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'ENVIAR REPORTE',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
