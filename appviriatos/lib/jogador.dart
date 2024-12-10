import 'package:flutter/material.dart';
import 'navbutton.dart'; // Importa o navbutton para o botão e lógica de navegação
import 'header.dart'; // Importa o CustomHeader

class JogadorPage extends StatefulWidget {
  final String jogadorNome; // Variável para armazenar o nome do jogador

  // Construtor para receber o nome do jogador
  JogadorPage({required this.jogadorNome});

  @override
  _JogadorPageState createState() => _JogadorPageState();
}

class _JogadorPageState extends State<JogadorPage> {
  int _currentIndex = 4; // Índice atual da página

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context); // Voltar à página anterior
        },
      ),
      body: Center(
        child: Text(
          'Detalhes de ${widget.jogadorNome}', // Exibe o nome do jogador
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
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
