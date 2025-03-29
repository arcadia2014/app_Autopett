import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegistrarMascotaScreen extends StatefulWidget {
  const RegistrarMascotaScreen({super.key});

  @override
  _RegistrarMascotaScreenState createState() => _RegistrarMascotaScreenState();
}

class _RegistrarMascotaScreenState extends State<RegistrarMascotaScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _rasgosController = TextEditingController();
  final TextEditingController _razaController = TextEditingController();
  final TextEditingController _saludController = TextEditingController();

  String _sexoSeleccionado = 'Macho';
  File? _image;

  final ImagePicker _picker = ImagePicker();

  // aqui puedes elegir una imagen
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _registrarMascota() {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes enviar los datos a Firebase o una base de datos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mascota registrada con éxito')),
      );

      // Opcional: Regresar al menú después del registro
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Mascota"),
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(255, 248, 238, 225), // Color café claro
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: const Color.fromARGB(
            255, 252, 220, 192), // Fondo detrás del formulario
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Nombre", _nombreController),
              _buildTextField("Edad (años)", _edadController, isNumeric: true),
              _buildTextField("Peso (kg)", _pesoController, isNumeric: true),
              _buildTextField("Rasgos Físicos", _rasgosController),
              _buildTextField("Raza", _razaController),
              _buildTextField("Estado de Salud", _saludController),
              _buildDropdownField("Sexo", ["Macho", "Hembra"]),
              _buildImagePicker(),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _registrarMascota,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Color del botón
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Ajusta el padding
                    minimumSize: const Size(100, 40), // Tamaño mínimo del botón
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

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Por favor, ingrese $label";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> opciones) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _sexoSeleccionado,
        items: opciones
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {
          setState(() {
            _sexoSeleccionado = value!;
          });
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Foto de la Mascota", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: _image == null
                  ? const Icon(Icons.camera_alt, size: 100, color: Colors.grey)
                  : Image.file(_image!, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
  
}