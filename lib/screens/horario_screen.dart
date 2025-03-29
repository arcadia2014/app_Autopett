import 'package:flutter/material.dart';

class HorarioScreen extends StatefulWidget {
  final String fecha;
  final String horario1;
  final String horario2;
  final String horario3;

  const HorarioScreen({
    super.key,
    required this.fecha,
    required this.horario1,
    required this.horario2,
    required this.horario3,
  });

  @override
  _HorarioScreen createState() => _HorarioScreen();
}

class _HorarioScreen extends State<HorarioScreen> {
  late String fecha;
  late String horario1;
  late String horario2;
  late String horario3;

  @override
  void initState() {
    super.initState();
    fecha = widget.fecha;
    horario1 = widget.horario1;
    horario2 = widget.horario2;
    horario3 = widget.horario3;
  }

  Widget _buildDataField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi mascota',
          style: TextStyle(color: Colors.brown),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 248, 238, 225),
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 252, 220, 192),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Nombre de la mascota
            Text(
              fecha,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 16),
            // Información de la mascota
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDataField('Fecha', fecha),
                    _buildDataField('Horario 1', horario1),
                    _buildDataField('Horario 2', horario2),
                    _buildDataField('Horario 3', horario3),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Botones de editar y eliminar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _mostrarDialogoEditar(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 240, 236, 234),
                    foregroundColor: const Color.fromARGB(121, 85, 72, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Editar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _mostrarDialogoEliminar(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Eliminar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoEditar(BuildContext context) {
    TextEditingController fechaController = TextEditingController(text: fecha);
    TextEditingController horario1Controller = TextEditingController(text: horario1);
    TextEditingController horario2Controller = TextEditingController(text: horario2);
    TextEditingController horario3Controller = TextEditingController(text: horario3);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Editar Horario',
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(90, 247, 197, 131),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Fecha', fechaController),
                _buildTextField('Horario 1', horario1Controller),
                _buildTextField('Horario 2', horario2Controller),
                _buildTextField('Horario 3', horario3Controller),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo sin guardar cambios
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  fecha = fechaController.text;
                  horario1 = horario1Controller.text;
                  horario2 = horario2Controller.text;
                  horario3 = horario3Controller.text;
                });
                Navigator.of(context).pop(); // Cerrar el diálogo después de guardar
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoEliminar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar este registro?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Eliminar los datos
                  fecha = '';
                  horario1 = '';
                  horario2 = '';
                  horario3 = '';
                });
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registro eliminado con éxito')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.brown,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 236, 217, 186),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}