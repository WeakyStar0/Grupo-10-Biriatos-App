import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  List<dynamic> tarefas = [];
  List<dynamic> filteredTarefas = [];
  bool isLoading = true;
  int _currentIndex = 2; // Índice atual da página (Tarefas = 2)

  @override
  void initState() {
    super.initState();
    fetchTarefas();
  }

  // Função para buscar as tarefas
  Future<void> fetchTarefas() async {
    const url = 'http://192.168.1.66:3000/tasks'; // Endpoint para buscar as tarefas
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> tasks = json.decode(response.body);

        // Para cada tarefa, buscar detalhes do jogador e do clube
        for (var task in tasks) {
          final athlete = await fetchAthlete(task['athleteId']);
          final team = await fetchTeam(task['teamId']);
          task['athleteName'] = athlete['fullName']; // Adiciona o nome do jogador
          task['teamName'] = team['teamName']; // Adiciona o nome do clube
        }

        setState(() {
          tarefas = tasks;
          filteredTarefas = tasks;
          isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar as tarefas');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao buscar tarefas: $error');
    }
  }

  // Função para buscar detalhes do jogador
  Future<Map<String, dynamic>> fetchAthlete(int athleteId) async {
    final url = 'http://192.168.1.66:3000/athletes/$athleteId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao buscar detalhes do jogador');
      }
    } catch (error) {
      print('Erro ao buscar jogador: $error');
      return {'fullName': 'Nome não encontrado'};
    }
  }

  // Função para buscar detalhes do clube
  Future<Map<String, dynamic>> fetchTeam(int teamId) async {
    final url = 'http://192.168.1.66:3000/teams/$teamId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao buscar detalhes do clube');
      }
    } catch (error) {
      print('Erro ao buscar clube: $error');
      return {'teamName': 'Clube não encontrado'};
    }
  }

  // Função para filtrar as tarefas
  void _searchTarefas(String query) {
    setState(() {
      filteredTarefas = tarefas.where((tarefa) {
        return tarefa['description']
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
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
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Indicador de carregamento
          : Column(
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
                          labelText: 'Pesquisar Tarefa',
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
                      final jogador = tarefa['athleteName'] ?? 'Nome não encontrado';
                      final clube = tarefa['teamName'] ?? 'Clube não encontrado';

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        elevation: 4.0, // Adiciona sombra ao card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Bordas arredondadas
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nome do jogador (destacado)
                              Text(
                                jogador,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Descrição da tarefa (menos destacada)
                              Text(
                                tarefa['description'],
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              // Nome do clube (menos destacado)
                              Text(
                                'Clube: $clube',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[600],
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