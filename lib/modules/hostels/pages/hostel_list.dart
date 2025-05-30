import 'package:flutter/material.dart';
import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/hostel_model.dart';
import 'package:proyecto_final/modules/hostels/pages/hostel_details.dart';

class HostelList extends StatelessWidget {
  const HostelList({super.key});

  Future<List<dynamic>> _fetchHostels() async {
    final client = ClientBase();
    final response = await client.clientDio.get("/albergues.php");
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
          "Albergues",
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
          future: _fetchHostels(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Tenemos problemas al mostrar los albergues, por favor, intente más tarde.",
                ),
              );
            }

            if (snapshot.hasData) {
              final data = snapshot.data!;

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final hostel = HostelModel.fromJson(data[index]);

                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.orange.shade400,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        hostel.building,
                        style: TextStyle(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        hostel.city,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          // color: Colors.orange.shade600,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.orange.shade800,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HostelDetails(hostel),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return Center(
              child: Text("No hay datos."),
            );
          },
        ),
      ),
    );
  }
}
