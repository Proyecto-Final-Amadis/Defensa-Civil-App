// data_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/models/albergue.dart';
import 'package:proyecto_final/models/medidads.dart';
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
