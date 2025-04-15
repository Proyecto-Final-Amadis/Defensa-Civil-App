import 'package:flutter/material.dart';
import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/defense_service_model.dart';

class DefenseServices extends StatelessWidget {
  const DefenseServices({super.key});

  Future<List<dynamic>> _fetchServices() async {
    final client = ClientBase();
    final response = await client.clientDio.get("/servicios.php");
    return response.data!["datos"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicios"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: _fetchServices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Tenemos problemas al mostrar los servicios, por favor, intente más tarde."),
              );
            }

            if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final service = DefenseServiceModel.fromJson(data[index]);
                  return GestureDetector(
                    onTap: () {
                      buildDialog(context, service.description);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            Image.network(
                              service.imageUrl,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                color: Colors.black.withAlpha(170),
                                child: Text(
                                  service.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Center(
              child: Text("Algo salió mal..."),
            );
          },
        ),
      ),
    );
  }
}

buildDialog(BuildContext context, String description) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Descripción"),
        content: Text(description),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Entendido"))
        ],
      );
    },
  );
}
