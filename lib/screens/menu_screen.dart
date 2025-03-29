import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú"),
        centerTitle: true, // Esto centra el título
        backgroundColor: Color.fromARGB(
            255, 248, 238, 225), // Color café claro para la parte superior
      ),
      body: Column(
        children: [
          // Imagen en la parte superior
          Container(
            height: 200, // Ajusta la altura según tu preferencia
            width: double.infinity, // Asegura que la imagen ocupe todo el ancho
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/menu_imagen.jpg'), // Cambia la ruta de la imagen
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Elimina el SizedBox y coloca un contenedor de color para el fondo detrás de los botones
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(
                    255, 252, 220, 192), // Fondo detrás de los botones
                borderRadius:
                    BorderRadius.circular(10), // Radio para bordes redondeados
              ),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: const EdgeInsets.all(16),
                children: [
                  _menuButton(context, 'Registrar Mascota', Icons.pets,
                      Colors.blue, '/register_pet'),
                  _menuButton(context, 'Registrar Dieta', Icons.restaurant_menu,
                      Colors.green, '/registrarDieta'),
                  _menuButton(context, 'Horario de Comida', Icons.schedule,
                      Colors.orange, '/horarioComida'),
                  _menuButton(context, 'Estado del Dispensador', Icons.percent,
                      Colors.red, '/estadoDispensador'),
                  _menuButton(context, 'Mi Mascota', Icons.pets, Colors.purple,
                      '/miMascota'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(BuildContext context, String text, IconData icon,
      Color color, String route) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Color de los botones
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 40, color: Colors.black), // Color negro para los íconos
          const SizedBox(height: 10),
          Text(text,
              style: const TextStyle(color: Colors.black)), // Texto negro
        ],
      ),
    );
  }
}
