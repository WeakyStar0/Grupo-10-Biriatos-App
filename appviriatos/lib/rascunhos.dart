import 'package:flutter/material.dart';

import 'header.dart'; // Certifica-te de que tens o ficheiro com o CustomHeader.

void main() {
  runApp(const RascunhosApp());
}

class RascunhosApp extends StatelessWidget {
  const RascunhosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RascunhosPage(),
    );
  }
}

class RascunhosPage extends StatelessWidget {
  RascunhosPage({Key? key}) : super(key: key);

  final List<Map<String, String>> rascunhos = [
    {
      'titulo': 'Rascunho Do Jogador 1',
      'data': 'Data de criação: __/__/____',
    },
    {
      'titulo': 'Rascunho Do Jogador 2',
      'data': 'Data de criação: __/__/____',
    },
  ];

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          // Título
          const Center(
            child: Text(
              'RASCUNHOS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Lista de rascunhos
          Expanded(
            child: ListView.builder(
              itemCount: rascunhos.length,
              itemBuilder: (context, index) {
                final rascunho = rascunhos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.description,
                        size: 32,
                        color: Colors.black,
                      ),
                      title: Text(
                        rascunho['titulo']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        rascunho['data']!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        // Ação ao clicar no rascunho
                        print('Rascunho ${rascunho['titulo']} clicado');
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: '',
          ),
        ],
        onTap: (index) {
          // Define as ações para cada ícone na barra de navegação
          print('Ícone $index clicado');
        },
      ),
    );
  }
}
