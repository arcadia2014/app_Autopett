import 'package:flutter/material.dart';

class MiMascotaScreen extends StatefulWidget {
  final String nombre;
  final String edad;
  final String peso;
  final String rasgos;
  final String raza;
  final String salud;
  final String sexo;
  final String? image;

  const MiMascotaScreen({
    super.key,
    required this.nombre,
    required this.edad,
    required this.peso,
    required this.rasgos,
    required this.raza,
    required this.salud,
    required this.sexo,
    this.image,
  });

  @override
  _MiMascotaScreenState createState() => _MiMascotaScreenState();
}

class _MiMascotaScreenState extends State<MiMascotaScreen> {
  late String nombre;
  late String edad;
  late String peso;
  late String rasgos;
  late String raza;
  late String salud;
  late String sexo;

  @override
  void initState() {
    super.initState();
    nombre = widget.nombre;
    edad = widget.edad;
    peso = widget.peso;
    rasgos = widget.rasgos;
    raza = widget.raza;
    salud = widget.salud;
    sexo = widget.sexo;
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
            // Imagen de la mascota
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
                image: widget.image != null && widget.image!.isNotEmpty
                    ? DecorationImage(
                        image: AssetImage(widget.image!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            // Nombre de la mascota
            Text(
              nombre,
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
                    _buildDataField('Edad', edad),
                    _buildDataField('Peso', peso),
                    _buildDataField('Rasgos', rasgos),
                    _buildDataField('Raza', raza),
                    _buildDataField('Salud', salud),
                    _buildDataField('Sexo', sexo),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Botón de editar
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
            const SizedBox(height: 16),
            // Botón de ver dieta
            ElevatedButton(
              onPressed: () {
                // Lógica para ver dieta
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 245, 247, 245),
                foregroundColor: const Color.fromARGB(121, 85, 72, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Ver Dieta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // cuadro de edición
  void _mostrarDialogoEditar(BuildContext context) {
    TextEditingController nombreController = TextEditingController(text: nombre);
    TextEditingController edadController = TextEditingController(text: edad);
    TextEditingController pesoController = TextEditingController(text: peso);
    TextEditingController rasgosController = TextEditingController(text: rasgos);
    TextEditingController razaController = TextEditingController(text: raza);
    TextEditingController saludController = TextEditingController(text: salud);
    TextEditingController sexoController = TextEditingController(text: sexo);


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Mascota', textAlign: TextAlign.center),
          backgroundColor: const Color.fromARGB(90, 247, 197, 131),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Nombre', nombreController),
                _buildTextField('Edad', edadController),
                _buildTextField('Peso', pesoController),
                _buildTextField('Rasgos', rasgosController),
                _buildTextField('Raza', razaController),
                _buildTextField('Salud', saludController),
                _buildTextField('Sexo', sexoController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo sin guardar cambios
              },
              style: TextButton.styleFrom(
              foregroundColor: Colors.black, // Cambiar el color del texto a negro
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  nombre = nombreController.text;
                  edad = edadController.text;
                  peso = pesoController.text;
                  rasgos = rasgosController.text;
                  raza = razaController.text;
                  salud = saludController.text;
                  sexo = sexoController.text;
                });
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, // Cambiar el color del texto a negro
              ),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // Widget para construir cuadros de datos
  Widget _buildDataField(String titulo, String valor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.brown[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(121, 85, 72, 1).withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$titulo: ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            TextSpan(
              text: valor,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir los campos de texto en el diálogo
  Widget _buildTextField(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.brown, // Cambia el color del texto de la etiqueta
          fontSize: 16, // Tamaño de la etiqueta
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 236, 217, 186),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.brown,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.brown,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.orange, // Color del borde
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 16.0,
        ),
        prefixIcon: Icon(
          Icons.edit,
          color: Colors.brown[300],
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
  );
}

}
