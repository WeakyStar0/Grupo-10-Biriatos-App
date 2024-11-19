import 'package:flutter/material.dart';

import 'header.dart'; // Certifica-te que tens o CustomHeader implementado no ficheiro header.dart

void main() {
  runApp(const TarefasApp());
}

class TarefasApp extends StatelessWidget {
  const TarefasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TarefasPage(),
    );
  }
}

class TarefasPage extends StatelessWidget {
  TarefasPage({Key? key}) : super(key: key);

  final List<Map<String, String>> jogos = [
    {
      'titulo': 'ACADÉMICO  X  TONDELA',
      'descricao': 'Equipa Profissional\n19:00 - 01/12/2024\nEstádio do Fontelo',
    },
    {
      'titulo': 'BOAVISTA  X  RIO AVE',
      'descricao': 'Sub-19\n19:00 - 02/12/2024\nEstádio do Bessa',
    },
    {
      'titulo': 'SL BENFICA  X  FC PORTO',
      'descricao': 'Equipa Profissional\n19:00 - 10/12/2024\nEstádio da Luz',
    },
    {
      'titulo': 'SC BRAGA  X  VITÓRIA SC',
      'descricao': 'Sub-23\n19:00 - 25/12/2024\nEstádio Municipal Braga',
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
              'TAREFAS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Barra de pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar Jogos',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Lista de jogos
          Expanded(
            child: ListView.builder(
              itemCount: jogos.length,
              itemBuilder: (context, index) {
                final jogo = jogos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jogo['titulo']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            jogo['descricao']!,
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Navegação inferior
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
