import 'package:flutter/material.dart';
import 'header.dart';
import 'navbutton.dart';
//imports 
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Jogadores',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PlayerListPage(),
    );
  }
}

class PlayerListPage extends StatelessWidget {
  final Map<String, List<String>> playerCategories = {
    'Guarda-redes': ['Jogador 1', 'Jogador 2', 'Jogador 3'],
    'Defesas': ['Jogador 2', 'Jogador 3', 'Jogador 4', 'Jogador 5'],
    'Médios': ['Jogador 6', 'Jogador 7'],
    'Avançados': ['Jogador 8', 'Jogador 9'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Académico - Equipamento'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implementar a funcionalidade de busca
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Função de busca ainda não implementada."),
              ));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: playerCategories.keys.length,
        itemBuilder: (context, index) {
          String category = playerCategories.keys.elementAt(index);
          List<String> players = playerCategories[category]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ...players.map((player) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.green[100], // Cor dos jogadores
                    child: Text(
                      player,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para o botão flutuante
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Ação do botão flutuante ainda não configurada."),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// o mark teve aqui: https://www.youtube.com/watch?v=dQw4w9WgXcQ 
