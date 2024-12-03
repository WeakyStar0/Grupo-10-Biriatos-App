import 'package:flutter/material.dart';

class RelatorioPage extends StatefulWidget {
  const RelatorioPage({super.key});

  @override
  _RelatorioPageState createState() => _RelatorioPageState();
}

class _RelatorioPageState extends State<RelatorioPage> {
  int? tecnica; // 1 a 4
  int? velocidade; // 1 a 4
  int? atitudeCompetitiva; // 1 a 4
  int? inteligencia; // 1 a 4
  String? altura; // Alto, Médio, Baixo
  String? morfologia; // Ectomorfo, Mesomorfo, Endomorfo
  int? ratingFinal; // 1 a 4
  final TextEditingController observacoesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'RELATÓRIO',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildOptionSelector('Técnica', 1, 4, (value) {
              setState(() {
                tecnica = value;
              });
            }, selectedValue: tecnica),
            const SizedBox(height: 10),
            buildOptionSelector('Velocidade', 1, 4, (value) {
              setState(() {
                velocidade = value;
              });
            }, selectedValue: velocidade),
            const SizedBox(height: 10),
            buildOptionSelector('Atitude competitiva', 1, 4, (value) {
              setState(() {
                atitudeCompetitiva = value;
              });
            }, selectedValue: atitudeCompetitiva),
            const SizedBox(height: 10),
            buildOptionSelector('Inteligência', 1, 4, (value) {
              setState(() {
                inteligencia = value;
              });
            }, selectedValue: inteligencia),
            const SizedBox(height: 10),
            buildTextSelector('Altura', ['Alto', 'Médio', 'Baixo'], (value) {
              setState(() {
                altura = value;
              });
            }, selectedValue: altura),
            const SizedBox(height: 10),
            buildTextSelector('Morfologia', ['Ectomorfo', 'Mesomorfo', 'Endomorfo'], (value) {
              setState(() {
                morfologia = value;
              });
            }, selectedValue: morfologia),
            const SizedBox(height: 10),
            buildOptionSelector('Rating final', 1, 4, (value) {
              setState(() {
                ratingFinal = value;
              });
            }, selectedValue: ratingFinal),
            const SizedBox(height: 20),
            TextField(
              controller: observacoesController,
              decoration: const InputDecoration(
                hintText: 'Observações',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para salvar
                    print('Dados guardados:');
                    printData();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text('GUARDAR'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para enviar
                    print('Dados enviados:');
                    printData();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text('ENVIAR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionSelector(String label, int min, int max, Function(int) onSelect,
      {int? selectedValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: List.generate(max - min + 1, (index) {
            int value = min + index;
            return GestureDetector(
              onTap: () => onSelect(value),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedValue == value ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    color: selectedValue == value ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildTextSelector(
      String label, List<String> options, Function(String) onSelect,
      {String? selectedValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: options.map((option) {
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedValue == option ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: selectedValue == option ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void printData() {
    print('Técnica: $tecnica');
    print('Velocidade: $velocidade');
    print('Atitude Competitiva: $atitudeCompetitiva');
    print('Inteligência: $inteligencia');
    print('Altura: $altura');
    print('Morfologia: $morfologia');
    print('Rating Final: $ratingFinal');
    print('Observações: ${observacoesController.text}');
  }
}