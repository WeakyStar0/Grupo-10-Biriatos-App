import 'package:flutter/material.dart';
import 'clubes.dart'; // Certifique-se de criar este arquivo.
import 'rascunhos.dart'; // Certifique-se de criar este arquivo.
import 'header.dart';

void main() {
  runApp(const Tarefas());
}

class Tarefas extends StatelessWidget {
  const Tarefas({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TarefasPage(),
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
      'time1': 'ACADÉMICO',
      'time2': 'TONDELA',
      'data': '01/12/2024',
      'hora': '19:00',
      'categoria': 'Equipa Profissional',
      'estadio': 'Estádio do Fontelo'
    },
    {
      'time1': 'BOAVISTA',
      'time2': 'RIO AVE',
      'data': '02/12/2024',
      'hora': '19:00',
      'categoria': 'Sub-19',
      'estadio': 'Estádio do Bessa'
    },
    {
      'time1': 'SL BENFICA',
      'time2': 'FC PORTO',
      'data': '10/12/2024',
      'hora': '19:00',
      'categoria': 'Equipa Profissional',
      'estadio': 'Estádio da Luz'
    },
    {
      'time1': 'SC BRAGA',
      'time2': 'VITÓRIA SC',
      'data': '25/12/2024',
      'hora': '19:00',
      'categoria': 'Sub-23',
      'estadio': 'Estádio Municipal Braga'
    },
  ];

  List<Map<String, String>> filteredTarefas = [];
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    filteredTarefas = tarefas;
  }

  void _searchTarefas(String query) {
    final filtered = tarefas.where((tarefa) {
      return tarefa['time1']!.toLowerCase().contains(query.toLowerCase()) ||
          tarefa['time2']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredTarefas = filtered;
    });
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ClubesPage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RascunhosPage()),
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Barra de pesquisa
                TextField(
                  controller: _searchController,
                  onChanged: _searchTarefas,
                  decoration: InputDecoration(
                    labelText: 'Pesquisar Jogos',
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Lista de tarefas
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = filteredTarefas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            '${tarefa['time1']} X ${tarefa['time2']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Data: ${tarefa['data']}'),
                              Text('Hora: ${tarefa['hora']}'),
                              Text('Categoria: ${tarefa['categoria']}'),
                              Text('Estádio: ${tarefa['estadio']}'),
                            ],
                          ),
                          onTap: () {
                            print('Tarefa clicada: ${tarefa['time1']} X ${tarefa['time2']}');
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          CustomFloatingButton(
            currentIndex: _currentIndex,
            onTap: _navigateToPage,
          ),
        ],
      ),
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
                    MaterialPageRoute(builder: (context) => const TarefasPage()),
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
                    MaterialPageRoute(builder: (context) => ClubesPage()),
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
                    MaterialPageRoute(builder: (context) => RascunhosPage()),
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
