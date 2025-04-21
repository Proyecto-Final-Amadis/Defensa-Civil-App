// mis_situaciones_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/modules/situaciones/reportar_situacion.dart';
import 'package:proyecto_final/providers/someproviders.dart';

class MisSituacionesPage extends ConsumerWidget {
  const MisSituacionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final situacionesAsyncValue = ref.watch(misSituacionesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Situaciones'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(misSituacionesProvider.future),
        child: situacionesAsyncValue.when(
          data: (data) {
            final situaciones = data.datos;

            if (situaciones.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.info_outline,
                        size: 70, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'No has reportado situaciones',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ReportarSituacionPage()),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Reportar Situación'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade800,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: situaciones.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final situacion = situaciones[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                      situacion.titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          situacion.descripcion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Estado: ${situacion.estado ?? "Pendiente"}',
                          style: TextStyle(
                            color: _getColorEstado(situacion.estado),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(misSituacionesProvider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade800,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ReportarSituacionPage()),
          );
        },
        backgroundColor: Colors.orange.shade800,
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getColorEstado(String? estado) {
    switch (estado?.toLowerCase()) {
      case 'aprobado':
      case 'completado':
      case 'resuelto':
        return Colors.green;
      case 'rechazado':
      case 'cancelado':
        return Colors.red;
      case 'en proceso':
      case 'en revisión':
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }
}
