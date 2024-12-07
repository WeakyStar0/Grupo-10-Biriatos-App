import 'package:flutter/material.dart';
import 'clubes.dart';
import 'tarefas.dart';
import 'header.dart';

class RascunhosPage extends StatefulWidget {
  @override
  _RascunhosPageState createState() => _RascunhosPageState();
}

class _RascunhosPageState extends State<RascunhosPage> {
  int _currentIndex = 1;

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

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ClubesPage()),
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
    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context);
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
