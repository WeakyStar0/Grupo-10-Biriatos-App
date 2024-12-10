import 'package:flutter/material.dart';
import 'navbutton.dart'; // Importa o navbutton para o botão e lógica de navegação
import 'header.dart'; // Importa o CustomHeader
import 'jogador.dart'; // Importa a página do jogador

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

  // Mapa de cores associadas a cada categoria
  final Map<String, Color> categoryColors = {
    'Guarda-redes': Color(0xFFC39B44),
    'Defesas': Color(0xFF2C9E8B),
    'Médios': Color(0xFF2B8B39),
    'Avançados': Color(0xFF9F574F),
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
            Color categoryColor = categoryColors[category]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FuturaStd', // Nome da fonte
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
                    return GestureDetector(
                      onTap: () {
                        // Navega para a página do jogador com o nome do jogador
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JogadorPage(
                              jogadorNome: players[index], // Passa o nome do jogador
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: categoryColor, // Define a cor do Card com base na categoria
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        elevation: 4.0,
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.person, // Placeholder como ícone
                                size: 50,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                            Positioned(
                              left: 8.0,
                              bottom: 8.0,
                              child: Text(
                                players[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white, // Cor do texto
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Futura Std Bold', // Nome da fonte
                                ),
                              ),
                            ),
                          ],
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
