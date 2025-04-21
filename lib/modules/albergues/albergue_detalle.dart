// albergue_detalle_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/providers/someproviders.dart';

class AlbergueDetallePage extends ConsumerWidget {
  final String id;

  const AlbergueDetallePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albergue = ref.watch(albergueDetalleProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text(albergue?.nombre ?? 'Detalle de Albergue'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: albergue == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    albergue.nombre,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.location_on,
                                color: Colors.orange.shade800),
                            title: const Text('Dirección'),
                            subtitle: Text(albergue.direccion),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone,
                                color: Colors.orange.shade800),
                            title: const Text('Teléfono'),
                            subtitle: Text(albergue.telefono),
                          ),
                          ListTile(
                            leading: Icon(Icons.people,
                                color: Colors.orange.shade800),
                            title: const Text('Capacidad'),
                            subtitle: Text('${albergue.capacidad} personas'),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_city,
                                color: Colors.orange.shade800),
                            title: const Text('Provincia'),
                            subtitle: Text(albergue.provincia),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.map),
                    label: const Text('Ver en el mapa'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    onPressed: () {
                      // Aquí puedes implementar la funcionalidad para abrir un mapa externo
                      // como Google Maps con las coordenadas del albergue
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
