import 'package:flutter/material.dart';
import 'navbutton.dart'; // Importa o navbutton para o botão e lógica de navegação
import 'header.dart'; // Importa o CustomHeader

class RelatorioPage extends StatefulWidget {
  const RelatorioPage({super.key});

  @override
  _RelatorioPageState createState() => _RelatorioPageState();
}

class _RelatorioPageState extends State<RelatorioPage> {
  int _currentIndex = 4; // Índice atual da página
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
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context); // Voltar à página anterior
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Título
              const Center(
                child: Text(
                  'RELATÓRIO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'FuturaStd', // Nome da família definida no pubspec.yaml
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildOptionSelector('Técnica', 1, 4, (value) {
                setState(() {
                  tecnica = value;
                });
              }, selectedValue: tecnica),
              const SizedBox(height: 20),
              buildOptionSelector('Velocidade', 1, 4, (value) {
                setState(() {
                  velocidade = value;
                });
              }, selectedValue: velocidade),
              const SizedBox(height: 20),
              buildOptionSelector('Atitude competitiva', 1, 4, (value) {
                setState(() {
                  atitudeCompetitiva = value;
                });
              }, selectedValue: atitudeCompetitiva),
              const SizedBox(height: 20),
              buildOptionSelector('Inteligência', 1, 4, (value) {
                setState(() {
                  inteligencia = value;
                });
              }, selectedValue: inteligencia),
              const SizedBox(height: 20),
              buildTextSelector('Altura', ['Alto', 'Médio', 'Baixo'], (value) {
                setState(() {
                  altura = value;
                });
              }, selectedValue: altura),
              const SizedBox(height: 20),
              buildTextSelector('Morfologia', ['Ectomorfo', 'Mesomorfo', 'Endomorfo'], (value) {
                setState(() {
                  morfologia = value;
                });
              }, selectedValue: morfologia),
              const SizedBox(height: 20),
              buildOptionSelector('Rating final', 1, 4, (value) {
                setState(() {
                  ratingFinal = value;
                });
              }, selectedValue: ratingFinal),
              const SizedBox(height: 30),
              TextField(
                controller: observacoesController,
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
                    onPressed: () {
                      // Lógica para salvar
                      print('Dados guardados:');
                      printData();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text('GUARDAR',
                     style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FuturaStd',
                      fontSize: 13,
                    ),
                    
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para enviar
                      print('Dados enviados:');
                      printData();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text('ENVIAR',
                     style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FuturaStd',
                      fontSize: 13,
                    ),
                    ),
                    
                  ),
                ],
              ),
              const SizedBox(height: 80), // Espaço extra no final
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
          padding: const EdgeInsets.only(left: 16.0, bottom: 5.0), // Espaço adicional abaixo do texto
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'FuturaStd Book',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(max - min + 1, (index) {
            int value = min + index;
            return GestureDetector(
              onTap: () => onSelect(value),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8), // Maior espaçamento horizontal
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Botão mais largo
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

  Widget buildTextSelector(
      String label, List<String> options, Function(String) onSelect,
      {String? selectedValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 5.0), // Espaço adicional abaixo do texto
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'FuturaStd Book',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: options.map((option) {
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8), // Maior espaçamento horizontal
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Botão mais largo
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
