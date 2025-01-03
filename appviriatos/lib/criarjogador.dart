import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importação do pacote intl para lidar com datas
import 'navbutton.dart';
import 'header.dart';

void main() {
  runApp(const CriarJogador());
}

class CriarJogador extends StatelessWidget {
  const CriarJogador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CriarJogadorPage(),
    );
  }
}

class CriarJogadorPage extends StatelessWidget {
  CriarJogadorPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _contactoController = TextEditingController();

  final List<String> _posicoes = ['Guarda-redes', 'Defesa', 'Médio', 'Avançado'];
  final List<String> _paises = ['Portugal', 'Brasil', 'Espanha', 'França', 'Alemanha'];
  final List<String> _clubes = ['Clube A', 'Clube B', 'Clube C'];

  String? _posicaoSelecionada;
  String? _paisSelecionado;
  String? _clubeSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'CRIAR JOGADOR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'FuturaStd',
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField('Nome', '', _nomeController),
                    const SizedBox(height: 5),
                    _buildDateField('Data de Nascimento', _dataController, context),
                    const SizedBox(height: 5),
                    _buildDropdownField('Posição', _posicoes, _posicaoSelecionada, (String? novoValor) {
                      _posicaoSelecionada = novoValor;
                    }),
                    const SizedBox(height: 5),
                    _buildDropdownField('Nacionalidade', _paises, _paisSelecionado, (String? novoValor) {
                      _paisSelecionado = novoValor;
                    }),
                    const SizedBox(height: 5),
                    _buildDropdownField('Clube', _clubes, _clubeSelecionado, (String? novoValor) {
                      _clubeSelecionado = novoValor;
                    }),
                    const SizedBox(height: 5),
                    _buildTextField('Contacto', '', _contactoController),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Captura e imprime os dados
                          final nome = _nomeController.text;
                          final dataNascimento = _dataController.text;
                          final posicao = _posicaoSelecionada;
                          final nacionalidade = _paisSelecionado;
                          final clube = _clubeSelecionado;
                          final contacto = _contactoController.text;

                          print('--- Dados do Jogador ---');
                          print('Nome: $nome');
                          print('Data de Nascimento: $dataNascimento');
                          print('Posição: $posicao');
                          print('Nacionalidade: $nacionalidade');
                          print('Clube: $clube');
                          print('Contacto: $contacto');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      ),
                      child: const Text(
                        'ENVIAR',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80), // Espaço adicional para evitar sobreposição
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

  int _currentIndex = 4;

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, preencha este campo.';
        }
        return null;
      },
    );
  }

  Widget _buildDateField(String label, TextEditingController controller, BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecione uma data.';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String? selectedValue, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: selectedValue,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecione uma opção.';
        }
        return null;
      },
    );
  }
}
