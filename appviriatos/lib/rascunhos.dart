import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navbutton.dart';
import 'header.dart';
import 'relatorio.dart';
import 'dart:convert';

class RascunhosPage extends StatefulWidget {
  @override
  _RascunhosPageState createState() => _RascunhosPageState();
}

class _RascunhosPageState extends State<RascunhosPage> {
  int _currentIndex = 1;
  List<Map<String, dynamic>> rascunhos = [];

  @override
  void initState() {
    super.initState();
    _carregarRascunhos();
  }

  Future<void> _carregarRascunhos() async {
    final prefs = await SharedPreferences.getInstance();
    final rascunhosSalvos = prefs.getStringList('rascunhos') ?? [];
    setState(() {
      rascunhos = rascunhosSalvos.map((r) => jsonDecode(r) as Map<String, dynamic>).toList();
    });
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
          const Center(
            child: Text(
              'RASCUNHOS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'FuturaStd',
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: rascunhos.length,
              itemBuilder: (context, index) {
                final rascunho = rascunhos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                        rascunho['fullName'], // Exibe o nome do jogador
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Data de criação: ${rascunho['dataCriacao']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        // Abrir o rascunho para edição
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RelatorioPage(
                              athleteId: rascunho['athleteId'],
                              fullName: rascunho['fullName'], // Passa o nome do jogador
                              rascunho: rascunho,
                            ),
                          ),
                        );
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
        onTap: (index) => navigateToPage(context, index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}