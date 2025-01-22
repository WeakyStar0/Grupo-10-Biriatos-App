import 'package:flutter/material.dart';
import 'navbutton.dart'; // Importa o navbutton para o botão de navegação
import 'header.dart'; // Importa o CustomHeader

void main() {
  runApp(const Tarefas());
}

class Tarefas extends StatelessWidget {
  const Tarefas({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TarefasPage(),
    );
  }
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);
  @override
  _TarefasPageState createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> tarefas = [
    {
      'jogador': 'Jogador 1',
      'time1': 'FC Porto',
      'time2': 'SL Benfica',
      
    },
    {
      'jogador': 'Jogador 2',
      'time1': 'Vitória SC',
      'time2': 'SC Braga',
      
    },
  ];

  List<Map<String, String>> filteredTarefas = [];
  int _currentIndex = 2; // Índice atual da página (Tarefas = 2)

  @override
  void initState() {
    super.initState();
    filteredTarefas = tarefas;
  }

  void _searchTarefas(String query) {
    final filtered = tarefas.where((tarefa) {
      return tarefa['jogador']!.toLowerCase().contains(query.toLowerCase()) ||
          tarefa['time1']!.toLowerCase().contains(query.toLowerCase()) ||
          tarefa['time2']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredTarefas = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context); // Voltar para a página anterior
        },
        
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 25),
          // Título
          const Center(
            child: Text(
              'TAREFAS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'FuturaStd', // Nome da família definida no pubspec.yaml
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Barra de pesquisa
                TextField(
                  controller: _searchController,
                  onChanged: _searchTarefas,
                  decoration: InputDecoration(
                    labelText: 'Pesquisar Jogador',
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Lista de tarefas
          Expanded(
            child: ListView.builder(
              itemCount: filteredTarefas.length,
              itemBuilder: (context, index) {
                final tarefa = filteredTarefas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${tarefa['jogador']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '${tarefa['time1']} x ${tarefa['time2']}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
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
