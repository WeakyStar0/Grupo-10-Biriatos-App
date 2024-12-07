import 'package:flutter/material.dart';
import 'tarefas.dart';
import 'rascunhos.dart';
import 'header.dart';

class ClubesPage extends StatefulWidget {
  @override
  _ClubesPageState createState() => _ClubesPageState();
}

class _ClubesPageState extends State<ClubesPage> {
  // Dados fictícios
  final List<Map<String, dynamic>> clubes = [
    {
      'nome': 'Benfica',
      'ranks': [
        {'nome': 'Rank 1', 'jogadores': ['Carlos Cunha', 'Rui Carreto']},
        {'nome': 'Rank 2', 'jogadores': ['Disney', 'Valter']}
      ],
    },
    {
      'nome': 'Porto',
      'ranks': [
        {'nome': 'Rank 1', 'jogadores': ['Miguel Santos', 'Rui Almeida']},
        {'nome': 'Rank 3', 'jogadores': ['André Matos', 'Vitor Sousa']}
      ],
    },
    {
      'nome': 'Sporting',
      'ranks': [
        {'nome': 'Rank 2', 'jogadores': ['Hugo Leite', 'Tiago Nunes']},
        {'nome': 'Rank 4', 'jogadores': ['Joana Costa', 'Ana Marques']}
      ],
    },
  ];

  String searchQuery = '';
  int _currentIndex = 0;

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RascunhosPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TarefasPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
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
      floatingActionButton: CustomFloatingButton(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CustomFloatingButton extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomFloatingButton({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                if (currentIndex != 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ClubesPage()),
                  );
                }
                onTap(0);
              },
              iconSize: 32.0,
              icon: Icon(
                Icons.sports_soccer,
                color: currentIndex == 0 ? Colors.white : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                if (currentIndex != 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RascunhosPage()),
                  );
                }
                onTap(1);
              },
              iconSize: 32.0,
              icon: Icon(
                Icons.group,
                color: currentIndex == 1 ? Colors.white : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                if (currentIndex != 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TarefasPage()),
                  );
                }
                onTap(2);
              },
              iconSize: 32.0,
              icon: Icon(
                Icons.task,
                color: currentIndex == 2 ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
