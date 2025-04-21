// medidas_preventivas_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/modules/medida_preventiva/detalle_medida_preventiva.dart';
import 'package:proyecto_final/providers/someproviders.dart';

class MedidasPreventivasPage extends ConsumerWidget {
  const MedidasPreventivasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medidasAsyncValue = ref.watch(medidasPreventivasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medidas Preventivas'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: medidasAsyncValue.when(
        data: (data) {
          final medidas = data.datos;

          return ListView.builder(
            itemCount: medidas.length,
            itemBuilder: (context, index) {
              final medida = medidas[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade800,
                    child: const Icon(Icons.warning, color: Colors.white),
                  ),
                  title: Text(
                    medida.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    medida.descripcion,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MedidaPreventivaDetallePage(id: medida.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
