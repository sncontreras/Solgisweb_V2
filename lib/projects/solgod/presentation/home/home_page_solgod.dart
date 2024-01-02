import 'package:flutter/material.dart';

import 'package:solgis/projects/solgod/presentation/pages/servicio/marcar_servicio_page.dart';

class HomePageSolgod extends StatelessWidget {
  const HomePageSolgod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Aquí iría tu fondo de la página, HomePageBackGroundPeople()
            _HomeHeaderPeople(),
            // Otros elementos de la página...
          ],
        ),
      ),
    );
  }
}

class _HomeHeaderPeople extends StatelessWidget {
  const _HomeHeaderPeople({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 200,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('SolGOD v2.7',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.05),
            // Otros elementos de encabezado...
            SizedBox(height: size.height * 0.02),
            // Ejemplo de módulo
            _ClickableModule(
              title: 'Relación tipo carga - campo',
              onPressed: () {
                // Navegación a la nueva ventana cuando se hace clic
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarcarServicioPage()),
                );
              },
            ),
            // Otros módulos similares...
          ],
        ),
      ),
    );
  }
}

// Widget reutilizable para módulos clicables
class _ClickableModule extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _ClickableModule({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.arrow_forward),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}

// Páginas de ejemplo que se abren al hacer clic en los módulos
class CampoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relación tipo carga - campo')),
      body: const Center(
        child: Text('Página de Relación tipo carga - campo'),
      ),
    );
  }
}

// Otras páginas similares para otros módulos...
