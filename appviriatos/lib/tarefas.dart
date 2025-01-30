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

  Future<void> fetchTarefas() async {
    final url = 'http://192.168.1.66:3000/tasks'; // Endpoint para buscar as tarefas
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          tarefas = json.decode(response.body);
          filteredTarefas = tarefas;
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
          ? Center(child: CircularProgressIndicator())
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
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Descrição: ${tarefa['description']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Jogador: ${tarefa['athleteId']}', // Aqui você pode buscar o nome do jogador pelo athleteId
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Clube: ${tarefa['teamId']}', // Aqui você pode buscar o nome do clube pelo teamId
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