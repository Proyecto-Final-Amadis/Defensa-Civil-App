import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutDevs extends StatelessWidget {
  const AboutDevs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Sobre los desarrolladores",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Contacto de Ariel Lázaro"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Teléfono: +1 809-999-3911"),
                        TextButton.icon(
                          icon: Icon(
                            Icons.copy_rounded,
                            color: Colors.orange.shade800,
                          ),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: "@Lazarito444"));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Contacto copiado al portapapeles"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          label: Text(
                            "Copiar contacto de Telegram",
                            style: TextStyle(
                              color: Colors.orange.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cerrar",
                          style: TextStyle(
                            color: Colors.orange.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 24,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/ariel.png',
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
                          child: const Text(
                            'Ariel David Lázaro Pérez',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Contacto de Jeriel Gómez"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Teléfono: +1 849-857-6040"),
                        TextButton.icon(
                          icon: Icon(
                            Icons.copy_rounded,
                            color: Colors.orange.shade800,
                          ),
                          onPressed: () {
                            //TODO: Añadir el @ de Telegram de Jeriel
                            Clipboard.setData(ClipboardData(text: ""));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Contacto copiado al portapapeles"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          label: Text(
                            "Copiar contacto de Telegram",
                            style: TextStyle(
                              color: Colors.orange.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cerrar",
                          style: TextStyle(
                            color: Colors.orange.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    //TODO: Añadir una imagen de Jeriel a los assets y añadirla a la pantalla
                    Image.network(
                      'https://media.licdn.com/dms/image/v2/D4E03AQG6x3QJ-tZ8jw/profile-displayphoto-shrink_800_800/B4EZVh8NajGgAg-/0/1741104928744?e=1750896000&v=beta&t=x19V8XijT6xNG4AdI5spwrKUMprJZsRGl0ilNhSmH3k',
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
                        child: const Text(
                          'Jeriel Elieser Gómez Susaña',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
  }
}
