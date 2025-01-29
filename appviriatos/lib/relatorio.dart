import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'navbutton.dart';
import 'header.dart';

class RelatorioPage extends StatefulWidget {
  const RelatorioPage({super.key});
  final int athleteId = 1; // Substituir pelo ID real do atleta

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

  Future<void> salvarRelatorio() async {
    final url = 'http://192.168.1.66:3000/reports';
    final Map<String, dynamic> reportData = {
      "athleteId": widget.athleteId,
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
      print('📤 Enviando relatório para $url');
      print('📄 Dados do relatório: $reportData');

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reportData),
      );

      print('✅ Resposta do servidor: ${response.statusCode}');
      print('🔹 Corpo da resposta: ${response.body}');

      if (response.statusCode == 201) {
        print('🎉 Relatório salvo com sucesso!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Relatório salvo com sucesso!"))
        );
      } else {
        print('❌ Erro ao salvar relatório: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar: ${response.body}"))
        );
      }
    } catch (e) {
      print('🚨 Erro na requisição: $e');
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
              buildOptionSelector('Técnica', 1, 4, (value) {
                setState(() {
                  technical = value;
                  print("🎯 Técnica selecionada: $technical");
                });
              }, selectedValue: technical),
              buildOptionSelector('Velocidade', 1, 4, (value) {
                setState(() {
                  speed = value;
                  print("⚡ Velocidade selecionada: $speed");
                });
              }, selectedValue: speed),
              buildOptionSelector('Atitude Competitiva', 1, 4, (value) {
                setState(() {
                  competitiveAttitude = value;
                  print("🔥 Atitude Competitiva selecionada: $competitiveAttitude");
                });
              }, selectedValue: competitiveAttitude),
              buildOptionSelector('Inteligência', 1, 4, (value) {
                setState(() {
                  intelligence = value;
                  print("🧠 Inteligência selecionada: $intelligence");
                });
              }, selectedValue: intelligence),
              buildTextSelector('Altura', ['High', 'Medium', 'Low'], (value) {
                setState(() {
                  height = value;
                  print("📏 Altura selecionada: $height");
                });
              }, selectedValue: height),
              buildTextSelector('Morfologia', ['Ectomorph', 'Mesomorph', 'Endomorph'], (value) {
                setState(() {
                  morphology = value;
                  print("🦴 Morfologia selecionada: $morphology");
                });
              }, selectedValue: morphology),
              buildOptionSelector('Classificação Final', 1, 4, (value) {
                setState(() {
                  finalRating = value;
                  print("⭐ Classificação Final selecionada: $finalRating");
                });
              }, selectedValue: finalRating),
              const SizedBox(height: 30),
              TextField(
                controller: freeTextController,
                decoration: const InputDecoration(
                  hintText: 'Observações',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (text) {
                  print("📝 Observações: $text");
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: salvarRelatorio,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text('GUARDAR', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: salvarRelatorio,
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

  Widget buildOptionSelector(String label, int min, int max, Function(int) onSelect,
      {int? selectedValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 5.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
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

  Widget buildTextSelector(String label, List<String> options, Function(String) onSelect,
      {String? selectedValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 5.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: options.map((option) {
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: selectedValue == option ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: selectedValue == option ? Colors.white : Colors.black,
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
