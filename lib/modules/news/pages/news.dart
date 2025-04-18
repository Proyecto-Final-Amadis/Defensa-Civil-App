import 'package:flutter/material.dart';
import 'package:proyecto_final/models/news_model.dart';

class News extends StatelessWidget {
  final NewsModel _model;

  const News(this._model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.orange.shade800),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          vertical: 15,
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(
                _model.imageUrl,
                width: double.infinity,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                _model.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.orange.shade800),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                _model.dateTime,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.orange.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                _model.content,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
