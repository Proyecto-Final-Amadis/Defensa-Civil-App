import 'package:flutter/material.dart';
import 'package:proyecto_final/models/hostel_model.dart';

class HostelDetails extends StatelessWidget {
  const HostelDetails(this._model, {super.key});

  final HostelModel _model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Albergue"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Text(_model.building),
      ),
    );
  }
}
