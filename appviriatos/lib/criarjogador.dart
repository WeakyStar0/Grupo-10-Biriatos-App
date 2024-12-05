import 'package:flutter/material.dart';

import 'header.dart'; // NAO SE ESQUECAM DE IMPORTAR O HEADER EM TODO O LADO QUE TEM HEADER OKAY??? @Reueben@x1cuu

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

  @override //HEADER ACHO EU -MARK
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context); // Voltar à página anterior
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Text(
                'CRIAR JOGADOR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'FuturaStd', // Nome da família definida no pubspec.yaml
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 15),
            // Formulário
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField('Nome', ''),
                  const SizedBox(height: 5),
                  _buildTextField('Data de Nascimento', ''),
                  const SizedBox(height: 5),
                  _buildTextField('Posição', ''),
                  const SizedBox(height: 5),
                  _buildTextField('Nacionalidade', ''),
                  const SizedBox(height: 5),
                  _buildTextField('Clube', ''),
                  const SizedBox(height: 5),
                  _buildTextField('Contacto', ''),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Processa os dados
                        print('Dados validados!');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
