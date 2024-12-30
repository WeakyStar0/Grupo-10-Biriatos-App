import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'navbutton.dart'; // Importa o navbutton para o botão e lógica de navegação
import 'header.dart'; // Importa o CustomHeader
import 'relatorio.dart'; // Importa a página Relatório

class EquipaPage extends StatefulWidget {
  @override
  _EquipaPageState createState() => _EquipaPageState();
}

class _EquipaPageState extends State<EquipaPage> {
  int _currentIndex = 4; // Índice atual da página

  // Lista de jogadores de exemplo com categorias
  final Map<String, String> jogadores = {
    'Jogador 1': 'Guarda-redes',
    'Jogador 2': 'Defesas',
    'Jogador 3': 'Médios',
    'Jogador 4': 'Avançados',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context); // Voltar à página anterior
        },
      ),
      body: ListView.builder(
        itemCount: jogadores.length,
        itemBuilder: (context, index) {
          String jogadorNome = jogadores.keys.elementAt(index);
          String jogadorCategoria = jogadores[jogadorNome]!;
          return Card(
            margin: EdgeInsets.zero, // Remove margens externas
            elevation: 4.0,
            child: ListTile(
              title: Text(jogadorNome),
              onTap: () {
                // Navegar para a página do jogador ao clicar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JogadorPage(
                      jogadorNome: jogadorNome,
                      jogadorCategoria: jogadorCategoria, // Passa a categoria
                    ),
                  ),
                );
              },
            ),
          );
        },
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
  final String jogadorCategoria; // Nova variável para a categoria do jogador

  // Construtor para receber o nome e a categoria do jogador
  JogadorPage({
    required this.jogadorNome,
    required this.jogadorCategoria,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context); // Voltar à página anterior
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  jogadorNome,
                  style: TextStyle(
                    fontFamily: 'FuturaStd', // Nome da família definida no pubspec.yaml
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Portugal 🇵🇹',
                  style: TextStyle(
                    fontFamily: 'FuturaStd',
                    fontSize: 20,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Jogador image section
          Center(
            child: Container(
              height: 100,
              width: 100,
              child: Icon(Icons.person, size: 100, color: Colors.black),
            ),
          ),

          // Retângulos com informações
          Stack(
            alignment: Alignment.center,
            children: [
              // Retângulos
              Container(
                width: double.infinity,
                height: 170,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              Container(
                width: double.infinity,
                height: 140,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              Container(
                width: double.infinity,
                height: 110,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Equipa: ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text('Sub-19', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Posição:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(jogadorCategoria, style: TextStyle(fontSize: 16, color: Colors.white)), // Usando categoria
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Data de \n Nascimento:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text('15/10/2006', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Center(
            child: Text(
              'Gerir Perfil',
              style: TextStyle(
                fontFamily: 'FuturaStd', // Nome da família definida no pubspec.yaml
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),

          // Botões de Contacto e Relatório
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
              children: [
                Container(
                  width: 150, // Define uma largura fixa para o botão
                  child: ElevatedButton(
                    onPressed: () {
                      // Show contact info popup
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(17),
                            content: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Telefone: ',
                                              style: TextStyle(
                                                fontFamily: 'FuturaStd',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '123456789',
                                              style: TextStyle(
                                                fontFamily: 'FuturaStd',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Nome: ',
                                              style: TextStyle(
                                                fontFamily: 'FuturaStd',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Nome do Contacto',
                                              style: TextStyle(
                                                fontFamily: 'FuturaStd',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: -55,
                                  left: -14,
                                  child: SvgPicture.asset(
                                    'web/icons/LOGO_Academico_Viseu_FC_fixed.svg',
                                    width: 90,
                                    height: 90,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'FuturaStd',
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 5), // Diminuindo o padding horizontal
                    ),
                    child: const Text(
                      'Contacto',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FuturaStd',
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15), // Espaçamento entre os botões
                Container(
                  width: 170, // Define uma largura fixa para o botão
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RelatorioPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 5), // Diminuindo o padding horizontal
                    ),
                    child: const Text(
                      'Criar Relatório',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FuturaStd',
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        currentIndex: 4,
        onTap: (index) => navigateToPage(context, index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
