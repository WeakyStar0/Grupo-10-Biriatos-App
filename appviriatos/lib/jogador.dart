import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'navbutton.dart';
import 'header.dart';
import 'relatorio.dart';

class JogadorPage extends StatelessWidget {
  final String jogadorNome;
  final String jogadorCategoria;
  final String clubeNome;
  final String dataNascimento;
  final String jogadorNacionalidade;
  final int athleteId; // Adicionando athleteId como parâmetro

  JogadorPage({
    required this.jogadorNome,
    required this.jogadorCategoria,
    required this.clubeNome,
    required this.dataNascimento,
    required this.jogadorNacionalidade,
    required this.athleteId, // Adicionando athleteId como parâmetro
  });

  Future<Map<String, String>> fetchAgentInfo(String playerName) async {
    final url = 'http://192.168.1.66:3000/agentInfo?playerName=$playerName';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'phone': data['phone'] ?? 'Desconhecido',
          'name': data['name'] ?? 'Desconhecido',
        };
      } else {
        throw Exception('Falha ao carregar informações do agente');
      }
    } catch (error) {
      print('Erro ao buscar informações do agente: $error');
      return {'phone': 'Erro', 'name': 'Erro'};
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(dataNascimento));

    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  jogadorNome,
                  style: TextStyle(
                    fontFamily: 'FuturaStd',
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jogadorNacionalidade,
                  style: TextStyle(
                    fontFamily: 'FuturaStd',
                    fontSize: 20,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
              height: 100,
              width: 100,
              child: Icon(Icons.person, size: 100, color: Colors.black),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 170,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              Container(
                width: double.infinity,
                height: 140,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              Container(
                width: double.infinity,
                height: 110,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Equipa:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(clubeNome, style: TextStyle(fontSize: 16, color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Posição:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(jogadorCategoria, style: TextStyle(fontSize: 16, color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Data de \nNascimento:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Gerir Perfil',
              style: TextStyle(
                fontFamily: 'FuturaStd',
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      final agentInfo = await fetchAgentInfo(jogadorNome);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(17),
                            content: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Contacto: ',
                                              style: TextStyle(
                                                fontFamily: 'FuturaStd',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text: agentInfo['phone'],
                                              style: TextStyle(
                                                fontFamily: 'FuturaStd',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Nome: ',
                                              style: TextStyle(
                                                fontFamily: 'FuturaStd',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text: agentInfo['name'],
                                              style: TextStyle(
                                                fontFamily: 'FuturaStd',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: -55,
                                  left: -14,
                                  child: SvgPicture.asset(
                                    'web/icons/LOGO_Academico_Viseu_FC_fixed.svg',
                                    width: 90,
                                    height: 90,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'FuturaStd',
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 5),
                    ),
                    child: const Text(
                      'Contacto',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FuturaStd',
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  width: 170,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RelatorioPage(athleteId: athleteId), // Passando o athleteId para RelatorioPage
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 5),
                    ),
                    child: const Text(
                      'Criar Relatório',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FuturaStd',
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        currentIndex: 4,
        onTap: (index) => navigateToPage(context, index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}