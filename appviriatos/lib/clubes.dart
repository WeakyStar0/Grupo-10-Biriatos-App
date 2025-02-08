import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Biblioteca para HTTP requests
import 'navbutton.dart'; // Importa o widget e a lógica de navegação
import 'header.dart'; // Importa o CustomHeader
import 'equipa.dart'; // Importa a página de Equipa

class ClubesPage extends StatefulWidget {
  @override
  _ClubesPageState createState() => _ClubesPageState();
}

class _ClubesPageState extends State<ClubesPage> {
  List<dynamic> clubes = []; // Lista dinâmica para armazenar os clubes
  String searchQuery = ''; // Variável de pesquisa
  int _currentIndex = 0; // Índice atual da página (Clubes = 0)
  bool isLoading = true; // Estado para controlar o carregamento

  @override
  void initState() {
    super.initState();
    fetchClubes(); // Chama a função para buscar os dados ao iniciar
  }

  Future<void> fetchClubes() async {
    const url = 'http://192.168.1.66:3000/teams'; // URL da API
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          // Filtra os clubes para exibir apenas aqueles com teamType: "Club"
          clubes = (json.decode(response.body) as List)
              .where((clube) => clube['teamType'] == "Club")
              .toList();
          isLoading = false; // Finaliza o carregamento
        });
      } else {
        throw Exception('Falha ao carregar os clubes');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao buscar clubes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtra os clubes de acordo com a pesquisa
    final filteredClubes = clubes.where((clube) {
      return clube['teamName']
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context); // Voltar à página anterior
        },
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Indicador de carregamento
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 25),
                // Título
                const Center(
                  child: Text(
                    'CLUBES',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'FuturaStd', // Nome da família definida no pubspec.yaml
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                // Campo de pesquisa
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Pesquisar clube',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                    },
                  ),
                ),
                // Lista de clubes filtrados
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredClubes.length,
                    itemBuilder: (context, index) {
                      final clube = filteredClubes[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            clube['teamName'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EquipaPage(
                                clubeNome: clube['teamName'],
                                teamId: clube['teamId'],
                                escalaoNome: 'Detalhes não disponíveis',
                                equipaNome: '',
                              ),
                            ),
                          );
                        },

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