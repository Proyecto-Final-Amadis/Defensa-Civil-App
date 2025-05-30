import 'package:flutter/material.dart';
import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/video_model.dart';
import 'package:proyecto_final/modules/videos/pages/video_details.dart';

class VideoList extends StatelessWidget {
  const VideoList({super.key});

  Future<List<dynamic>> _fetchVideos() async {
    final clientBase = ClientBase();
    final response = await clientBase.clientDio.get("/videos.php");
    return response.data["datos"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Videos",
          style: TextStyle(
            color: Colors.orange.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: FutureBuilder(
          future: _fetchVideos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Tenemos problemas para mostrar los videos, intente más tarde.",
                ),
              );
            }

            if (snapshot.hasData) {
              final videos = snapshot.data!;
              return ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = VideoModel.fromJson(videos[index]);
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.orange.shade400,
                        width: 2,
                      ),
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: ListTile(
                      tileColor: Colors.grey.shade50,
                      title: Text(
                        video.title,
                        style: TextStyle(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        video.date,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.orange.shade600,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.orange.shade800,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoDetails(video),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return const Center(
              child: Text("No hay videos disponibles."),
            );
          },
        ),
      ),
    );
  }
}
