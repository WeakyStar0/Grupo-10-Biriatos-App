import 'package:flutter/material.dart';
import 'navbutton.dart'; // Importa o widget e a lógica de navegação
import 'header.dart'; // Importa o CustomHeader
import 'equipa.dart'; // Importa a página de Equipa

class ClubesPage extends StatefulWidget {
  @override
  _ClubesPageState createState() => _ClubesPageState();
}

class _ClubesPageState extends State<ClubesPage> {
  final List<Map<String, dynamic>> clubes = [
    {
      'nome': 'Académico de Viseu', 
      'ranks': [
        {'nome': 'Equipa Profissional', 'jogadores': ['']},
        {'nome': 'Sub-23', 'jogadores': ['']},
        {'nome': 'Sub-19', 'jogadores': ['Equipa A', 'Equipa B']},
        {'nome': 'Formação masculino', 'jogadores': ['Sub - 16 A', 'Sub - 16 B', 'Sub - 14', 'Sub -13', 'Sub - 12 A', 'Sub - 12 B', 'Sub - 11', 'Sub - 10']},
        {'nome': 'Formação feminino', 'jogadores': ['Seniores', 'Sub - 19', 'Sub - 15', 'Sub - 13']},
      ],
    },
    {
      'nome': 'FC Porto',
      'ranks': [
        {'nome': 'Rank 1', 'jogadores': ['Miguel Santos', 'Rui Almeida']},
        {'nome': 'Rank 3', 'jogadores': ['André Matos', 'Vitor Sousa']}
      ],
    },
    {
      'nome': 'Sl Benfica',
      'ranks': [
        {'nome': 'Rank 2', 'jogadores': ['Hugo Leite', 'Tiago Nunes']},
        {'nome': 'Rank 4', 'jogadores': ['Joana Costa', 'Ana Marques']}
      ],
    },
  ];

  String searchQuery = ''; // Variável de pesquisa
  int _currentIndex = 0; // Índice atual da página (Clubes = 0)

  @override
  Widget build(BuildContext context) {
    // Filtra os clubes de acordo com a pesquisa
    final filteredClubes = clubes
        .where((clube) =>
            clube['nome'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

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
              'CLUBES',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'FuturaStd', // Nome da família definida no pubspec.yaml
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Campo de pesquisa
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar clube',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
          ),
          // Lista de clubes filtrados
          Expanded(
            child: ListView.builder(
              itemCount: filteredClubes.length,
              itemBuilder: (context, index) {
                final clube = filteredClubes[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text(
                      clube['nome'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    children: clube['ranks'].map<Widget>((rank) {
                      return ExpansionTile(
                        title: Text(
                          rank['nome'],
                          style: TextStyle(fontSize: 16),
                        ),
                        children: rank['jogadores'].map<Widget>((jogador) {
                          return ListTile(
                            title: Text(jogador),
                            onTap: () {
                              if (rank['nome'] == 'Sub-19' && jogador == 'Equipa A') {
                                // Navegar para a página de Equipa apenas para "Equipa A"
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EquipaPage(),
                                  ),
                                );
                              }
                            },
                          );
                        }).toList(),
                      );
                    }).toList(),
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
