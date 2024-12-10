import 'package:flutter/material.dart';
import 'navbutton.dart'; // Importa o navbutton para o botão e lógica de navegação
import 'header.dart'; // Importa o CustomHeader

class EquipaPage extends StatefulWidget {
  @override
  _EquipaPageState createState() => _EquipaPageState();
}

class _EquipaPageState extends State<EquipaPage> {
  int _currentIndex = 4; // Índice atual da página

  // Lista de jogadores de exemplo
  final List<String> jogadores = ['Jogador 1', 'Jogador 2', 'Jogador 3', 'Jogador 4'];

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
        child: ListView.builder(
          itemCount: jogadores.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4.0,
              child: ListTile(
                title: Text(jogadores[index]),
                onTap: () {
                  // Navegar para a página do jogador ao clicar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JogadorPage(jogadorNome: jogadores[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
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

class JogadorPage extends StatelessWidget {
  final String jogadorNome; // Variável para armazenar o nome do jogador

  // Construtor para receber o nome do jogador
  JogadorPage({required this.jogadorNome});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Jogador image section
            Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200], // Placeholder color for the image
              ),
              child: Icon(Icons.person, size: 80, color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              jogadorNome,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Portugal 🇵🇹', // Placeholder for country
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Equipa: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sub-19', // Placeholder
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Posição: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Guarda-redes', // Placeholder
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Data de Nascimento: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '15/10/2006', // Placeholder
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Buttons section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add profile management functionality here
                  },
                  child: Text('Gerir Perfil'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add reporting functionality here
                  },
                  child: Text('Criar Relatório'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show contact info popup
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Contacto'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Telefone: 123456789'),
                          Text('Nome: Mark António Nogueira Vicente de Pinho'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Contacto'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        currentIndex: 0,
        onTap: (index) => navigateToPage(context, index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
