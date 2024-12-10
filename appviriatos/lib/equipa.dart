import 'package:flutter/material.dart';
import 'navbutton.dart'; // Importa o navbutton para o botão e lógica de navegação
import 'header.dart'; // Importa o CustomHeader

class EquipaPage extends StatefulWidget {
  @override
  _EquipaPageState createState() => _EquipaPageState();
}

class _EquipaPageState extends State<EquipaPage> {
  int _currentIndex = 4; // Índice atual da página

  final Map<String, List<String>> playerCategories = {
    'Guarda-redes': ['Jogador 1', 'Jogador 2', 'Jogador 3'],
    'Defesas': ['Jogador 4', 'Jogador 5', 'Jogador 6', 'Jogador 7', 'Jogador 8'],
    'Médios': ['Jogador 9', 'Jogador 10', 'Jogador 11'],
    'Avançados': ['Jogador 12', 'Jogador 13', 'Jogador 14'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context); // Voltar à página anterior
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: playerCategories.keys.map((category) {
            List<String> players = playerCategories[category]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true, // Permite o GridView se ajustar ao tamanho da tela
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 jogadores por linha
                    crossAxisSpacing: 8.0, // Espaçamento entre os itens
                    mainAxisSpacing: 8.0, // Espaçamento entre as linhas
                  ),
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      elevation: 4.0,
                      child: Center(
                        child: Text(
                          players[index],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }).toList(),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        currentIndex: _currentIndex,
        onTap: (index) => navigateToPage(context, index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}