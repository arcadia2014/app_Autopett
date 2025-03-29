import 'package:flutter/material.dart';

class RegisterHorarioScreen extends StatefulWidget {
  final String fecha; // Parámetro para recibir la fecha seleccionada

  const RegisterHorarioScreen({super.key, required this.fecha});

  @override
  State<RegisterHorarioScreen> createState() => _RegisterHorarioScreenState();
}

class _RegisterHorarioScreenState extends State<RegisterHorarioScreen> {
  final _formKey = GlobalKey<FormState>();

  TimeOfDay? _horario1;
  TimeOfDay? _horario2;
  TimeOfDay? _horario3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Horarios de Comida'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 248, 238, 225),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: const Color.fromARGB(255, 252, 220, 192),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Mostrar la fecha seleccionada
              Text(
                'Fecha seleccionada: ${widget.fecha}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 16),
              _buildTimePicker('Horario 1', _horario1, (newTime) {
                setState(() {
                  _horario1 = newTime;
                });
              }),
              _buildTimePicker('Horario 2', _horario2, (newTime) {
                setState(() {
                  _horario2 = newTime;
                });
              }),
              _buildTimePicker('Horario 3', _horario3, (newTime) {
                setState(() {
                  _horario3 = newTime;
                });
              }),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (_horario1 != null || _horario2 != null || _horario3 != null) {
                      // Aquí puedes guardar los datos en la base de datos o backend
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Horarios registrados con éxito')),
                      );
                      Navigator.pop(context); // Regresar a la pantalla anterior
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Por favor, selecciona al menos un horario')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    minimumSize: const Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Registrar",
                    style: TextStyle(color: Color.fromARGB(235, 137, 77, 4)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay? selectedTime, Function(TimeOfDay) onTimeSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
              if (pickedTime != null) {
                onTimeSelected(pickedTime);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),  
            ),
            child: Text(
              selectedTime != null
                  ? selectedTime.format(context) // Mostrar la hora seleccionada
                  : 'Seleccionar hora',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}