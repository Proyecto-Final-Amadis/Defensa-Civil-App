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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Noticias",
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
          future: _fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange.shade800,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Tenemos problemas para mostrar las noticias, intente más tarde.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
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
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.orange.shade200,
                        width: 3,
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.grey.shade50,
                      title: Text(
                        newsItem.title,
                        style: TextStyle(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        newsItem.dateTime,
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
              child: Text(
                "Algo salió mal.",
                style: TextStyle(
                  color: Colors.orange.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
