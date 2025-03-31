import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DispensadorScreen extends StatefulWidget {
  const DispensadorScreen({Key? key}) : super(key: key);

  @override
  DispensadorScreenState createState() => DispensadorScreenState();
}

class DispensadorScreenState extends State<DispensadorScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  double nivelComida1 = 0.0;
  double nivelComida2 = 0.0;

  @override
  void initState() {
    super.initState();

    // Escucha para el primer sensor
    _database.child("sensores/sensor1/porcentaje").onValue.listen((event) {
      if (event.snapshot.value != null && mounted) {
        setState(() {
          nivelComida1 = double.parse(event.snapshot.value.toString());
        });
      }
    });

    // Escucha para el segundo sensor
    _database.child("sensores/sensor2/porcentaje").onValue.listen((event) {
      if (event.snapshot.value != null && mounted) {
        setState(() {
          nivelComida2 = double.parse(event.snapshot.value.toString());
        });
      }
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Nivel de dispensador")),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Primera barra de progreso
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 70, // Tamaño del círculo
          height: 70,
          child: CircularProgressIndicator(
            value: (nivelComida1 / 100.0).clamp(0.0, 1.0),
            backgroundColor: Colors.grey[350],
            valueColor: AlwaysStoppedAnimation<Color>(
              nivelComida1 > 50
                  ? Colors.green
                  : nivelComida1 > 30
                      ? Colors.orange
                      : Colors.red,
            ),
            strokeWidth: 18,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Comida: ${nivelComida1.toStringAsFixed(1)}%",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),

    // Segunda barra de progreso
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 70, // Tamaño del círculo
          height: 70,
          child: CircularProgressIndicator(
            value: (nivelComida2 / 100.0).clamp(0.0, 1.0),
            backgroundColor: Colors.grey[350],
            valueColor: AlwaysStoppedAnimation<Color>(
              nivelComida2 > 50
                  ? Colors.green
                  : nivelComida2 > 30
                      ? Colors.orange
                      : Colors.red,
            ),
            strokeWidth: 18,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Agua: ${nivelComida2.toStringAsFixed(1)}%",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ],
),

          
          const SizedBox(height: 50), 
          // Fila con los tres círculos pequeños
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Primer círculo pequeño
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15), 
                  const Text(
                    "100% lleno",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),

              // Segundo círculo pequeño
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 19), 
                  const Text(
                    "50% lleno",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),

              // Tercer círculo pequeño
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15), 
                  const Text(
                    "30% lleno",
                    style: TextStyle(fontSize: 14), 
                  ),
                ],
              ),
            ],
          ),

          // Espaciado entre los círculos y el texto
          const SizedBox(height: 30),

          
         Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0),
  child: Container(
    padding: const EdgeInsets.all(15.0),//espacio
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 228, 227, 227), 
      borderRadius: BorderRadius.circular(15), 
    ),
    child: Text(
      nivelComida1 > 50
          ? "Detalles: El nivel actual de alimentos indica que hay un stock suficiente disponible."
          : nivelComida1 > 30
              ? "Detalles: El nivel actual de alimentos indica que hay un stock moderado disponible, adecuado para operaciones regulares."
              : "Detalles: El nivel actual de alimentos es bajo. Se recomienda rellenar el dispensador lo antes posible.",
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, color: Colors.black54),
    ),
  ),
),
        ],
      ),
    ),
  );
}
}