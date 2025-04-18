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
          horizontal: 30,
          vertical: 15,
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                _model.building,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Ciudad",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Text(
                _model.city,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(children: [
                    Text(
                      "Código",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      _model.code,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ]),
                  SizedBox(
                    width: 50,
                  ),
                  Column(children: [
                    Text(
                      "Capacidad",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      _model.capacity.isEmpty || _model.capacity == "-"
                          ? "N/A"
                          : _model.capacity,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ]),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Coordinador",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Text(
                _model.coordinator,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Teléfono",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Text(
                _model.phone,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(children: [
                    Text(
                      "Latitud",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      _model.latitude,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ]),
                  SizedBox(
                    width: 50,
                  ),
                  Column(children: [
                    Text(
                      "Longitud",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      _model.longitude,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
