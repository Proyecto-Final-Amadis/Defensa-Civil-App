import 'package:flutter/material.dart';
import 'package:proyecto_final/config/dio.dart';
import 'package:proyecto_final/models/news_model.dart';
import 'package:proyecto_final/modules/news/pages/news.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  Future<List<dynamic>> _fetchNews() async {
    final client = ClientBase();
    final response = await client.clientDio.get("/noticias.php");
    return response.data!["datos"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticias"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: FutureBuilder(
          future: _fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Tenemos problemas para mostrar las noticias, intente más tarde.",
                ),
              );
            }

            if (snapshot.hasData) {
              final news = snapshot.data!;
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  final newsItem = NewsModel.fromJson(news[index]);
                  return Card(
                    child: ListTile(
                      title: Text(newsItem.title),
                      subtitle: Text(newsItem.dateTime),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => News(newsItem),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return Center(
              child: Text("Algo salió mal."),
            );
          },
        ),
      ),
    );
  }
}
