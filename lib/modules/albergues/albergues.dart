// mapa_albergues_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:proyecto_final/modules/albergues/albergue_detalle.dart';
import 'package:proyecto_final/providers/someproviders.dart';

class MapaAlberguesPage extends ConsumerWidget {
  const MapaAlberguesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alberguesAsyncValue = ref.watch(alberguesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Albergues'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: alberguesAsyncValue.when(
        data: (data) {
          final albergues = data.datos;

          return Column(
            children: [
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                        18.7357, -70.1627), // Centro de República Dominicana
                    zoom: 8.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: albergues.map((albergue) {
                        return Marker(
                          width: 40.0,
                          height: 40.0,
                          point: LatLng(
                            double.tryParse(albergue.lng) ?? 0.0,
                            double.tryParse(albergue.lat) ?? 0.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AlbergueDetallePage(id: albergue.codigo),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.location_on,
                              color: Colors.orange.shade800,
                              size: 40.0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
