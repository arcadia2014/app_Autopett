import 'dart:ui'; // Necesario para el filtro borroso
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes agregar lógica para Firebase Auth o tu backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registro exitoso")),
      );
      Navigator.pop(context); // Regresar a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo con filtro oscuro
          Image.asset(
            'assets/images/fondo_registro.jpg', // Cambia esta ruta a tu imagen
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Oscurecer la imagen
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_add, size: 80, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "Regístrate",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Crea una cuenta para continuar",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 30),

                  // Contenedor con filtro borroso
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Nombre
                              TextFormField(
                                controller: _nameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Nombre",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  prefixIcon: const Icon(Icons.person,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? "Ingrese su nombre" : null,
                              ),
                              const SizedBox(height: 15),

                              // Correo electrónico
                              TextFormField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Correo electrónico",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  prefixIcon: const Icon(Icons.email,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value!.contains("@")
                                    ? null
                                    : "Ingrese un correo válido",
                              ),
                              const SizedBox(height: 15),

                              // Contraseña
                              TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Contraseña",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) => value!.length < 6
                                    ? "Mínimo 6 caracteres"
                                    : null,
                              ),
                              const SizedBox(height: 15),

                              // Confirmar contraseña
                              TextFormField(
                                controller: _confirmPasswordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "Confirmar contraseña",
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) =>
                                    value != _passwordController.text
                                        ? "No coinciden"
                                        : null,
                              ),
                              const SizedBox(height: 20),

                              // Botón de registro
                              ElevatedButton(
                                onPressed: _register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 119, 111, 86),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Registrarse"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Derechos de autor en la parte inferior
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "FUTURETECH© 2025 TODOS LOS DERECHOS RESERVADOS",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
