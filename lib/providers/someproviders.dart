// data_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/models/albergue.dart';
import 'package:proyecto_final/models/medidads.dart';
import 'package:proyecto_final/models/situacion.dart';
import 'package:proyecto_final/services/someservices.dart';

// Provider para los albergues
final alberguesProvider = FutureProvider<AlberguesResponse>((ref) async {
  return await ApiService().getAlbergues();
});

// Provider para medidas preventivas
final medidasPreventivasProvider =
    FutureProvider<MedidasPreventivasResponse>((ref) async {
  return await ApiService().getMedidasPreventivas();
});

// Provider para un albergue específico
final albergueDetalleProvider =
    Provider.family<AlbergueModel?, String>((ref, id) {
  final alberguesAsyncValue = ref.watch(alberguesProvider);

  return alberguesAsyncValue.when(
    data: (data) => data.datos.firstWhere((albergue) => albergue.id == id,
        orElse: () => AlbergueModel(
            id: '',
            nombre: '',
            direccion: '',
            telefono: '',
            capacidad: '',
            latitud: '',
            longitud: '',
            provincia: '')),
    loading: () => null,
    error: (_, __) => null,
  );
});

// Provider para una medida preventiva específica
final medidaPreventivaDetalleProvider =
    Provider.family<MedidaPreventivaModel?, String>((ref, id) {
  final medidasAsyncValue = ref.watch(medidasPreventivasProvider);

  return medidasAsyncValue.when(
    data: (data) => data.datos.firstWhere((medida) => medida.id == id,
        orElse: () => MedidaPreventivaModel(
            id: '', titulo: '', descripcion: '', imagen: '')),
    loading: () => null,
    error: (_, __) => null,
  );
});

final misSituacionesProvider = FutureProvider<SituacionesResponse>((ref) async {
  return await ApiService().getMisSituaciones();
});

// Provider para reportar una nueva situación
final reportarSituacionProvider =
    FutureProvider.family<GeneralResponse, SituacionModel>(
        (ref, situacion) async {
  return await ApiService().reportarSituacion(situacion);
});

final situacionSeleccionadaProvider =
    Provider.family<SituacionModel?, String>((ref, id) {
  final situacionesAsyncValue = ref.watch(misSituacionesProvider);

  return situacionesAsyncValue.when(
    data: (data) => data.datos.firstWhere(
      (situacion) => situacion.id == id,
      orElse: () => SituacionModel(
        titulo: '',
        descripcion: '',
        foto: '',
        latitud: '',
        longitud: '',
      ),
    ),
    loading: () => null,
    error: (_, __) => null,
  );
});
