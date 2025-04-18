import 'package:flutter/material.dart';
import 'package:proyecto_final/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails(this._model, {super.key});

  final VideoModel _model;

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget._model.link,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles del video"),
      ),
      body: Padding(
        padding: EdgeInsets.all(35),
        child: Center(
          child: Column(
            children: [
              Text(
                widget._model.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Fecha: ${widget._model.date}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Descripción",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget._model.description,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
