import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Map<String, dynamic>> _sliderItems = [
    {
      'image':
          'https://defensacivil.gob.do/images/publicaciones/Servicios/EXTRICACION_VEHICULAR.JPG',
      'title': 'Técnica de Extracción y Extricación Vehicular.',
      'description':
          'La Unidad de Extricación Vehicular entra en acción cuando hay accidentes de fuerte impacto, donde quedan personas atrapadas dentro de vehículos'
    },
    {
      'image':
          'https://defensacivil.gob.do/images/thumbnails/images/thumbnails/images/publicaciones/Servicios/Atencion_Prehospitalaria_opt-fit-399x267.jpeg',
      'title': 'Atención Prehospitalaria',
      'description':
          'La Defensa Civil cuenta con un equipo de médicos y técnicos en emergencia médicas que en caso de una emergencia brindan las primeras atenciones en la valorización de la escena.'
    },
    {
      'image':
          'https://defensacivil.gob.do/images/thumbnails/images/publicaciones/Servicios/B%C3%BAsqueda_y_Rescate_en_Monta%C3%B1a-fit-485x322.jpg',
      'title': 'Búsqueda, Localización y rescate en montañas',
      'description':
          'La Unidad de Búsqueda y Rescate en Montañas emplea procedimientos para localizar personas en montañas y zonas boscosas'
    },
    {
      'image':
          'https://defensacivil.gob.do/images/thumbnails/images/publicaciones/Servicios/Salvamento_Acuatico_opt-fit-1000x666.jpg',
      'title': 'Salvamento Acuático',
      'description':
          'La Unidad de Salvamento Acuático es un equipo especializado en búsqueda y rescate de víctimas en aguas rápidas (TREPI).'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade600,
        elevation: 0,
        title: const Text(
          'Defensa Civil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con fondo degradado
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 30, top: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange.shade600,
                    Colors.orange.shade400,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '¡Bienvenido!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Conoce más sobre nuestras actividades y misión',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange.shade50,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Título "Nuestras Acciones"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.volunteer_activism, color: Colors.orange.shade800),
                  const SizedBox(width: 10),
                  Text(
                    'Nuestras Acciones',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Carrusel de imágenes
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 220,
                viewportFraction: 0.85,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
              ),
              items: _sliderItems.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.network(
                              item['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    item['description'],
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            // Indicadores del carrusel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _sliderItems.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 12,
                    height: 12,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange.withOpacity(
                        _currentSlide == entry.key ? 0.9 : 0.3,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // Sección de Historia
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.history, color: Colors.orange.shade800),
                  const SizedBox(width: 10),
                  Text(
                    'Nuestra Historia',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Contenido de Historia
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fundada para Proteger',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'La Defensa Civil fue fundada con el propósito de proteger a la población civil en situaciones de emergencia y desastres naturales. A lo largo de los años, nuestra organización ha evolucionado para convertirse en un pilar fundamental en la gestión de riesgos y respuesta ante emergencias.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Desde sus inicios, la organización ha formado a miles de voluntarios dedicados que día a día trabajan para crear comunidades más seguras y resilientes.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Video de la historia
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(15),
                      //   child: YoutubePlayer(
                      //     controller: _youtubeController,
                      //     showVideoProgressIndicator: true,
                      //     progressIndicatorColor: Colors.orange.shade600,
                      //     progressColors: ProgressBarColors(
                      //       playedColor: Colors.orange.shade600,
                      //       handleColor: Colors.orange.shade800,
                      //     ),
                      //     bottomActions: [
                      //       CurrentPosition(),
                      //       ProgressBar(
                      //         isExpanded: true,
                      //         colors: ProgressBarColors(
                      //           playedColor: Colors.orange.shade600,
                      //           handleColor: Colors.orange.shade800,
                      //         ),
                      //       ),
                      //       RemainingDuration(),
                      //       FullScreenButton(),
                      //     ],
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Sección de botones rápidos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.touch_app, color: Colors.orange.shade800),
                  const SizedBox(width: 10),
                  Text(
                    'Accesos Rápidos',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Tarjetas de acceso rápido
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildQuickAccessCard(
                    context,
                    Icons.volunteer_activism,
                    'Ser Voluntario',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TestScreen(title: 'Ser Voluntario')),
                    ),
                  ),
                  const SizedBox(width: 15),
                  _buildQuickAccessCard(
                    context,
                    Icons.campaign,
                    'Emergencias',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TestScreen(title: 'Emergencias')),
                    ),
                  ),
                  const SizedBox(width: 15),
                  _buildQuickAccessCard(
                    context,
                    Icons.school,
                    'Capacitación',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TestScreen(title: 'Capacitación')),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.orange.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.orange.shade600,
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange.shade700,
                    Colors.orange.shade500,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.shield,
                      size: 40,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Defensa Civil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Protección y Servicio',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              Icons.home,
              'Inicio',
              () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              context,
              Icons.info,
              'Acerca de Nosotros',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TestScreen(title: 'Acerca de Nosotros')),
                );
              },
            ),
            _buildDrawerItem(
              context,
              Icons.volunteer_activism,
              'Voluntariado',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TestScreen(title: 'Voluntariado')),
                );
              },
            ),
            _buildDrawerItem(
              context,
              Icons.campaign,
              'Emergencias',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TestScreen(title: 'Emergencias')),
                );
              },
            ),
            _buildDrawerItem(
              context,
              Icons.event,
              'Eventos',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TestScreen(title: 'Eventos')),
                );
              },
            ),
            _buildDrawerItem(
              context,
              Icons.school,
              'Capacitaciones',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TestScreen(title: 'Capacitaciones')),
                );
              },
            ),
            const Divider(thickness: 1),
            _buildDrawerItem(
              context,
              Icons.phone,
              'Contacto',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TestScreen(title: 'Contacto')),
                );
              },
            ),
            _buildDrawerItem(
              context,
              Icons.account_circle,
              'Mi Perfil',
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TestScreen(title: 'Mi Perfil')),
                );
              },
            ),
            _buildDrawerItem(
              context,
              Icons.logout,
              'Cerrar Sesión',
              () {
                Navigator.pop(context);
                // Implementar cierre de sesión
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange.shade600),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true,
    );
  }
}

// Pantalla de prueba para la navegación
class TestScreen extends StatelessWidget {
  final String title;

  const TestScreen({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade600,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: Colors.orange.shade300,
            ),
            const SizedBox(height: 20),
            Text(
              '¡Página de $title!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Esta es una página de prueba para demostrar la navegación',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade600,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
