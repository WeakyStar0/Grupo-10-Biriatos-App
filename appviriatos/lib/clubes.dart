import 'package:flutter/material.dart';



void main() {
  runApp(ClubesPage());
}

class ClubesPage extends StatelessWidget {
  const ClubesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Clubs List'),
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

// Rest of your ListPage and its content remain unchanged


class _ListPageState extends State<ListPage> {
  // Define clubs and their ranks
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

  // Define ranks for each club
  final Map<String, List<String>> ranks = {
    "Benfica": ["Primeira Liga", "UEFA Champions League", "Taça de Portugal"],
    "Sporting": ["Primeira Liga", "UEFA Europa League", "Taça de Portugal"],
    "Porto": ["Primeira Liga", "UEFA Champions League", "Taça de Portugal"],
    "Braga": ["Primeira Liga", "UEFA Europa League", "Taça de Portugal"],
    "Vitória de Guimarães": ["Primeira Liga", "Taça de Portugal"],
    "Boavista": ["Primeira Liga", "Taça de Portugal"],
    "Estoril Praia": ["Primeira Liga"],
    "Casa Pia": ["Primeira Liga"],
    "Marítimo": ["Primeira Liga"],
    "Portimonense": ["Primeira Liga"],
    "Rio Ave": ["Primeira Liga"],
    "Gil Vicente": ["Primeira Liga"],
    "Vizela": ["Primeira Liga"],
    "Chaves": ["Primeira Liga"],
    "Famalicão": ["Primeira Liga"],
    "Moreirense": ["Primeira Liga"],
    "Tondela": ["Liga Portugal 2"],
    "Nacional": ["Liga Portugal 2"],
    "Académico de Viseu": ["Liga Portugal 2"],
    "Feirense": ["Liga Portugal 2"],
    "Farense": ["Liga Portugal 2"],
    "Leixões": ["Liga Portugal 2"],
    "Penafiel": ["Liga Portugal 2"],
    "Estrela da Amadora": ["Liga Portugal 2"],
    "Académica de Coimbra": ["Liga Portugal 2"],
    "Varzim": ["Liga Portugal 2"],
    "Mafra": ["Liga Portugal 2"],
    "Oliveirense": ["Liga Portugal 2"],
    "Sporting da Covilhã": ["Liga Portugal 2"],
    "Torreense": ["Liga Portugal 2"],
    "Benfica B": ["Liga Portugal 2"],
    "Porto B": ["Liga Portugal 2"],
    "União de Leiria": ["Campeonato de Portugal"],
    "Sanjoanense": ["Campeonato de Portugal"],
    "Montalegre": ["Campeonato de Portugal"],
    "Alverca": ["Campeonato de Portugal"],
    "Felgueiras": ["Campeonato de Portugal"],
    "Real SC": ["Campeonato de Portugal"],
    "Amora": ["Campeonato de Portugal"],
    "Cova da Piedade": ["Campeonato de Portugal"],
    "Fontinhas": ["Campeonato de Portugal"],
    "Belenenses": ["Campeonato de Portugal"],
    "Vitória de Setúbal": ["Campeonato de Portugal"],
    "Anadia": ["Campeonato de Portugal"],
    "Oriental Dragon": ["Campeonato de Portugal"],
    "Sporting B": ["Campeonato de Portugal"],
    "Sertanense": ["Campeonato de Portugal"],
    "Marinhense": ["Campeonato de Portugal"]
  };

  // Define players for each club and rank
  final Map<String, Map<String, List<String>>> players = {
    "Benfica": {
      "Primeira Liga": ["Player 1", "Player 2", "Player 3"],
      "UEFA Champions League": ["Player A", "Player B"],
      "Taça de Portugal": ["Player X", "Player Y"]
    },
    "Sporting": {
      "Primeira Liga": ["Player 4", "Player 5"],
      "UEFA Europa League": ["Player C", "Player D"],
      "Taça de Portugal": ["Player Z"]
    },
    "Porto": {
      "Primeira Liga": ["Player 6", "Player 7", "Player 8"],
      "UEFA Champions League": ["Player E", "Player F"],
      "Taça de Portugal": ["Player W"]
    },
    "Braga": {
      "Primeira Liga": ["Player 9", "Player 10"],
      "UEFA Europa League": ["Player G", "Player H"],
      "Taça de Portugal": ["Player V"]
    },
    // Add players for other teams here
  };

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Clubs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search clubs...",
                prefixIcon: Icon(Icons.search),
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
            SizedBox(height: 16),
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
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...divisionClubs.map((club) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                club,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
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
    );
  }
}

class DetailPage extends StatelessWidget {
  final String club;
  final List<String> ranks;
  final Map<String, List<String>> players;

  DetailPage({required this.club, required this.ranks, required this.players});

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
            Text(
              'Ranks:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...ranks.map((rank) => Text(rank)).toList(),
            SizedBox(height: 16),
            Text(
              'Players:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...players.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.key, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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