import 'package:flutter/material.dart';
import 'navbutton.dart'; // Importa o navbutton para o botão e lógica de navegação
import 'header.dart'; // Importa o CustomHeader

class RascunhosPage extends StatefulWidget {
  @override
  _RascunhosPageState createState() => _RascunhosPageState();
}

class _RascunhosPageState extends State<RascunhosPage> {
  int _currentIndex = 1; // Índice atual da página (Rascunhos = 1)

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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 25),
          // Título
          const Center(
            child: Text(
              'RASCUNHOS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'FuturaStd', // Nome da família definida no pubspec.yaml
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 40,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
      // Botão de navegação flutuante
      floatingActionButton: CustomFloatingButton(
        currentIndex: _currentIndex,
        onTap: (index) => navigateToPage(context, index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
