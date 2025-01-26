import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'navbutton.dart';
import 'header.dart';
import 'jogador.dart';

class EquipaPage extends StatefulWidget {
  final String clubeNome;
  final int teamId;
  final String escalaoNome;
  final String equipaNome;

  EquipaPage({
    required this.clubeNome,
    required this.teamId,
    required this.escalaoNome,
    required this.equipaNome,
  });

  @override
  _EquipaPageState createState() => _EquipaPageState();
}

class _EquipaPageState extends State<EquipaPage> {
  int _currentIndex = 4;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> atletas = [];
  List<dynamic> filteredAtletas = [];
  bool isLoading = true;

  final Map<String, Color> categoryColors = {
    'Guarda-redes': Color(0xFFC39B44),
    'Defesa': Color(0xFF2C9E8B),
    'Médio': Color(0xFF2B8B39),
    'Avançado': Color(0xFF9F574F),
  };

  @override
  void initState() {
    super.initState();
    fetchAtletas();
  }

  Future<void> fetchAtletas() async {
    final url = 'http://192.168.1.66:3000/athletes?teamId=${widget.teamId}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          atletas = json.decode(response.body);
          filteredAtletas = atletas;
          isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar os atletas');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Erro ao buscar atletas: $error');
    }
  }

  void _searchAtletas(String query) {
    setState(() {
      filteredAtletas = atletas.where((atleta) {
        return atleta['fullName']
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }

  Map<String, List<dynamic>> _categorizeAtletas() {
    final Map<String, List<dynamic>> categorized = {
      'Guarda-redes': [],
      'Defesa': [],
      'Médio': [],
      'Avançado': [],
    };

    for (var atleta in filteredAtletas) {
      final position = atleta['position'] ?? '';
      if (categorized.containsKey(position)) {
        categorized[position]?.add(atleta);
      }
    }

    return categorized;
  }

  @override
  Widget build(BuildContext context) {
    final categorizedAtletas = _categorizeAtletas();

    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      widget.clubeNome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'FuturaStd',
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      '${widget.escalaoNome} ${widget.equipaNome}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'FuturaStd',
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _searchAtletas,
                      decoration: InputDecoration(
                        labelText: 'Pesquisar Jogador',
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                  Expanded(
                    child: ListView(
                      children: categorizedAtletas.keys.map((category) {
                        final players = categorizedAtletas[category] ?? [];
                        if (players.isEmpty) return Container();

                        final categoryColor = categoryColors[category] ?? Colors.grey;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontFamily: 'FuturaStdHeavy',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 15.0,
                              ),
                              itemCount: players.length,
                              itemBuilder: (context, index) {
                                final player = players[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JogadorPage(
                                          jogadorNome: player['fullName'],
                                          jogadorCategoria: category,
                                          clubeNome: widget.clubeNome,
                                          dataNascimento: player['dateOfBirth'],
                                          jogadorNacionalidade: player['nationality'] ?? 'Desconhecido',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: categoryColor,
                                    margin: EdgeInsets.symmetric(vertical: 4.0),
                                    elevation: 4.0,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.white.withOpacity(0.5),
                                          ),
                                        ),
                                        Positioned(
                                          left: 8.0,
                                          bottom: 8.0,
                                          child: Text(
                                            player['fullName'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Futura Std Bold',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 63),
                ],
              ),
            ),
      floatingActionButton: CustomFloatingButton(
        currentIndex: _currentIndex,
        onTap: (index) => navigateToPage(context, index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
