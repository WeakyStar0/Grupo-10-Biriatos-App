import 'package:flutter/material.dart';

import 'header.dart'; // Certifica-te que o ficheiro header.dart existe com o CustomHeader implementado.

void main() {
  runApp(const CriarJogador());
}

class CriarJogador extends StatelessWidget {
  const CriarJogador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CriarJogadorPage(), // Define a página inicial
    );
  }
}

class CriarJogadorPage extends StatelessWidget {
  CriarJogadorPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context); // Voltar à página anterior
        },
        onProfile: () {
          // Ação ao clicar no botão de perfil
          print('Perfil clicado');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logótipo no topo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/shield.png', // Substituir pelo caminho correto do escudo
                  height: 40,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Formulário
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField('Nome', 'Introduza o Nome Completo'),
                  const SizedBox(height: 16),
                  _buildTextField('Data de Nascimento', 'Introduza a Data de nascimento'),
                  const SizedBox(height: 16),
                  _buildTextField('Posição', 'Introduza a Posição'),
                  const SizedBox(height: 16),
                  _buildTextField('Nacionalidade', 'Introduza a Nacionalidade'),
                  const SizedBox(height: 16),
                  _buildTextField('Clube', 'Introduza o Clube'),
                  const SizedBox(height: 16),
                  _buildTextField('Contacto', 'Introduza o Contacto'),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Processa os dados
                        print('Dados validados!');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'ENVIAR',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, preencha este campo.';
        }
        return null;
      },
    );
  }
}
