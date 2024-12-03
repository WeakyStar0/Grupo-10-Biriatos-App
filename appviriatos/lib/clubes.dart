import 'package:flutter/material.dart';
import 'navbutton.dart'; // Certifica-te de que tens o ficheiro com o botão customizado.

void main() {
  runApp(const ClubesPage());
}

class ClubesPage extends StatelessWidget {
  const ClubesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Clubs List'),
      ),
      body: const ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final Map<String, List<String>> clubs = {
    'Primeira Liga': [
      "Benfica",
      "Sporting",
      "Porto",
      "Braga",
      "Vitória de Guimarães",
      "Boavista",
      "Estoril Praia",
      "Casa Pia",
      "Marítimo",
      "Portimonense",
      "Rio Ave",
      "Gil Vicente",
      "Vizela",
      "Chaves",
      "Famalicão",
      "Moreirense"
    ],
    'Liga Portugal 2': [
      "Tondela",
      "Nacional",
      "Académico de Viseu",
      "Feirense",
      "Farense",
      "Leixões",
      "Penafiel",
      "Estrela da Amadora",
      "Académica de Coimbra",
      "Varzim",
      "Mafra",
      "Oliveirense",
      "Sporting da Covilhã",
      "Torreense",
      "Benfica B",
      "Porto B"
    ],
    'Campeonato de Portugal': [
      "União de Leiria",
      "Sanjoanense",
      "Montalegre",
      "Alverca",
      "Felgueiras",
      "Real SC",
      "Amora",
      "Cova da Piedade",
      "Fontinhas",
      "Belenenses",
      "Vitória de Setúbal",
      "Anadia",
      "Oriental Dragon",
      "Sporting B",
      "Sertanense",
      "Marinhense"
    ]
  };

  final Map<String, List<String>> ranks = {/* Conteúdo original */};

  final Map<String, Map<String, List<String>>> players = {/* Conteúdo original */};

  String searchQuery = "";
  int currentIndex = 0;

  void onButtonTap(int index) {
    setState(() {
      currentIndex = index;
    });
    // Adiciona a navegação aqui, se necessário
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Clubs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search clubs...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: clubs.entries.map((entry) {
                  String division = entry.key;
                  List<String> divisionClubs = entry.value
                      .where((club) => club.toLowerCase().contains(searchQuery))
                      .toList();

                  if (divisionClubs.isEmpty) {
                    return Container();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          division,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...divisionClubs.map((club) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                club,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.green),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      club: club,
                                      ranks: ranks[club] ?? [],
                                      players: players[club] ?? {},
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        currentIndex: currentIndex,
        onTap: onButtonTap,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
    );
  }
}

class DetailPage extends StatelessWidget {
  final String club;
  final List<String> ranks;
  final Map<String, List<String>> players;

  const DetailPage({
    Key? key,
    required this.club,
    required this.ranks,
    required this.players,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(club),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ranks:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...ranks.map((rank) => Text(rank)).toList(),
            const SizedBox(height: 16),
            const Text(
              'Players:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...players.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.key,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  ...entry.value.map((player) => Text(player)),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
