import 'package:flutter/material.dart';

void main() {
  runApp(const Tarefas()); // Executa o app com a página de Tarefas
}

class Tarefas extends StatelessWidget {
  const Tarefas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Remove o banner de debug
      home: TarefasPage(),  // A página inicial será a TarefasPage
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

  @override
  void initState() {
    super.initState();
    filteredTarefas = tarefas;  // Inicializa com todas as tarefas
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: TarefaSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Padding(
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
                      title: Text('${tarefa['time1']} X ${tarefa['time2']}'),
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
                        // Adicionar ação de clicar na tarefa (ex: abrir detalhes)
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
    );
  }
}

// SearchDelegate para a pesquisa
class TarefaSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> tarefas = [
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

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpa a pesquisa
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = tarefas.where((tarefa) {
      return tarefa['time1']!.toLowerCase().contains(query.toLowerCase()) ||
             tarefa['time2']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final tarefa = results[index];
        return ListTile(
          title: Text('${tarefa['time1']} X ${tarefa['time2']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Data: ${tarefa['data']}'),
              Text('Hora: ${tarefa['hora']}'),
              Text('Categoria: ${tarefa['categoria']}'),
              Text('Estádio: ${tarefa['estadio']}'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = tarefas.where((tarefa) {
      return tarefa['time1']!.toLowerCase().contains(query.toLowerCase()) ||
             tarefa['time2']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final tarefa = suggestions[index];
        return ListTile(
          title: Text('${tarefa['time1']} X ${tarefa['time2']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Data: ${tarefa['data']}'),
              Text('Hora: ${tarefa['hora']}'),
              Text('Categoria: ${tarefa['categoria']}'),
              Text('Estádio: ${tarefa['estadio']}'),
            ],
          ),
        );
      },
    );
  }
}
