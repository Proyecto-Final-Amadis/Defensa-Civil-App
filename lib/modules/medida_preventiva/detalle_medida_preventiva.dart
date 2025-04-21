// medida_preventiva_detalle_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/providers/someproviders.dart';

class MedidaPreventivaDetallePage extends ConsumerWidget {
  final String id;

  const MedidaPreventivaDetallePage({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medida = ref.watch(medidaPreventivaDetalleProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text(medida?.titulo ?? 'Medida Preventiva'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: medida == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://tudominio.com/images/${medida.imagen}'),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) => const SizedBox(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      medida.titulo,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      medida.descripcion,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Aquí podrías agregar más información si en el futuro
                    // la API proporciona más datos sobre las medidas preventivas
                  ],
                ),
              ),
            ),
    );
  }
}
