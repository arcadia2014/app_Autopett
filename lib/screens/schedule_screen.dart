import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'register_horario_screen.dart'; // Importa la pantalla de registro de horarios

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Horarios de Dispensación"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 209, 185, 153),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: CalendarFormat.month,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_selectedDay != null) {
                // Navegar a RegisterHorarioScreen con la fecha seleccionada
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterHorarioScreen(
                      fecha: _selectedDay!.toLocal().toString().split(' ')[0], // Pasar la fecha seleccionada
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor, seleccione una fecha')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text("Programar Alimentación"),
          ),
        ],
      ),
    );
  }
}