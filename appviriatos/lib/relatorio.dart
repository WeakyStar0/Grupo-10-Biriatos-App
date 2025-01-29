import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'navbutton.dart';
import 'header.dart';
import 'menu.dart'; // Importe a página menu.dart

class RelatorioPage extends StatefulWidget {
  const RelatorioPage({super.key, required this.athleteId});

  final int athleteId; // Agora o athleteId é passado como parâmetro

  @override
  _RelatorioPageState createState() => _RelatorioPageState();
}

class _RelatorioPageState extends State<RelatorioPage> {
  int _currentIndex = 4;

  int? technical;
  int? speed;
  int? competitiveAttitude;
  int? intelligence;
  String? height;
  String? morphology;
  int? finalRating;
  final TextEditingController freeTextController = TextEditingController();

  final int userId = 1; // Substituir pelo ID real do usuário

  // Mapas para converter exibição em português para valores em inglês
  final Map<String, String> heightMap = {
    'Alto': 'High',
    'Médio': 'Medium',
    'Baixo': 'Low'
  };

  final Map<String, String> morphologyMap = {
    'Ectomorfo': 'Ectomorph',
    'Mesomorfo': 'Mesomorph',
    'Endomorfo': 'Endomorph'
  };

  Future<void> salvarRelatorio({bool enviar = false}) async {
    final url = 'http://192.168.1.66:3000/reports';
    final Map<String, dynamic> reportData = {
      "athleteId": widget.athleteId, // Usando o athleteId passado como parâmetro
      "userId": userId,
      "technical": technical,
      "speed": speed,
      "competitiveAttitude": competitiveAttitude,
      "intelligence": intelligence,
      "height": height,
      "morphology": morphology,
      "finalRating": finalRating,
      "freeText": freeTextController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reportData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Relatório salvo com sucesso!"))
        );

        // Se o botão "ENVIAR" foi pressionado, navegue para a página menu.dart
        if (enviar) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MenuPage(), // Navega para a página menu.dart
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar: ${response.body}"))
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro na requisição: $e"))
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'RELATÓRIO',
                  style: TextStyle(
                    fontFamily: 'FuturaStd',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildOptionSelector('Técnica', 1, 4, (value) => setState(() => technical = value), selectedValue: technical),
              buildOptionSelector('Velocidade', 1, 4, (value) => setState(() => speed = value), selectedValue: speed),
              buildOptionSelector('Atitude Competitiva', 1, 4, (value) => setState(() => competitiveAttitude = value), selectedValue: competitiveAttitude),
              buildOptionSelector('Inteligência', 1, 4, (value) => setState(() => intelligence = value), selectedValue: intelligence),
              buildTextSelector('Altura', heightMap, (value) => setState(() => height = value), selectedValue: height),
              buildTextSelector('Morfologia', morphologyMap, (value) => setState(() => morphology = value), selectedValue: morphology),
              buildOptionSelector('Classificação Final', 1, 4, (value) => setState(() => finalRating = value), selectedValue: finalRating),
              const SizedBox(height: 30),
              TextField(
                controller: freeTextController,
                decoration: const InputDecoration(
                  hintText: 'Observações',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => salvarRelatorio(enviar: false), // Botão "GUARDAR"
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text('GUARDAR', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () => salvarRelatorio(enviar: true), // Botão "ENVIAR"
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text('ENVIAR', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        currentIndex: _currentIndex,
        onTap: (index) => navigateToPage(context, index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildOptionSelector(String label, int min, int max, Function(int) onSelect, {int? selectedValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 5.0),
          child: Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(max - min + 1, (index) {
            int value = min + index;
            return GestureDetector(
              onTap: () => onSelect(value),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: selectedValue == value ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    color: selectedValue == value ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildTextSelector(String label, Map<String, String> options, Function(String) onSelect, {String? selectedValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 5.0),
          child: Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: options.keys.map((key) {
            return GestureDetector(
              onTap: () => onSelect(options[key]!),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: selectedValue == options[key] ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  key,
                  style: TextStyle(
                    color: selectedValue == options[key] ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}