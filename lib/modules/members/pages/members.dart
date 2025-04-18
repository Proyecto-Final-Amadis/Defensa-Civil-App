import 'package:flutter/material.dart';
import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/member_model.dart';

class Members extends StatelessWidget {
  const Members({super.key});

  Future<List<dynamic>> _fetchMembers() async {
    final client = ClientBase();
    final response = await client.clientDio.get("/miembros.php");
    return response.data!["datos"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Miembros",
          style: TextStyle(
            color: Colors.orange.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: FutureBuilder(
          future: _fetchMembers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Tenemos problemas al mostrar los miembros, por favor, intente más tarde.",
                ),
              );
            }

            if (snapshot.hasData) {
              final data = snapshot.data!;

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final member = MemberModel.fromJson(data[index]);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          Image.network(
                            member.imageUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              color: Colors.black.withAlpha(170),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    member.position,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
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
