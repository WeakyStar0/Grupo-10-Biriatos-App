import 'package:flutter/material.dart';
import 'navbutton.dart'; // Certifica-te de que tens o ficheiro com o botão customizado.
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

  final int currentIndex = 1;

  void onButtonTap(int index) {
    // Adiciona lógica para navegação ou outra ação, se necessário.
    print('Botão pressionado: $index');
  }

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
      floatingActionButton: CustomFloatingButton(
        currentIndex: currentIndex,
        onTap: onButtonTap,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
