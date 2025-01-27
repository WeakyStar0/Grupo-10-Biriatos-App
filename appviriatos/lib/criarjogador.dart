import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class CriarJogadorPage extends StatefulWidget {
  CriarJogadorPage({Key? key}) : super(key: key);

  @override
  _CriarJogadorPageState createState() => _CriarJogadorPageState();
}

class _CriarJogadorPageState extends State<CriarJogadorPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  final List<String> _posicoes = ['Guarda-redes', 'Defesa', 'Médio', 'Avançado'];
  final List<String> _paises = ['Portugal', 'Brasil', 'Espanha', 'França', 'Alemanha'];
  final List<String> _generos = ['Male', 'Female', 'Other'];
  final Map<String, String> _generosDisplay = {
    'Male': 'Masculino',
    'Female': 'Feminino',
    'Other': 'Outro'
  };

  List<dynamic> _clubes = [];
  String? _posicaoSelecionada;
  String? _paisSelecionado;
  String? _clubeSelecionado;
  String? _generoSelecionado;
  bool _isLoadingClubes = true;

  @override
  void initState() {
    super.initState();
    fetchClubes();
  }

  Future<void> fetchClubes() async {
    const url = 'http://192.168.1.66:3000/teams';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _clubes = json.decode(response.body);
          _isLoadingClubes = false;
        });
      } else {
        throw Exception('Falha ao carregar clubes');
      }
    } catch (error) {
      setState(() {
        _isLoadingClubes = false;
      });
      print('Erro ao buscar clubes: $error');
    }
  }

  Future<void> _enviarDados(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final nome = _nomeController.text;
      final dataNascimento = _dataController.text;
      final posicao = _posicaoSelecionada ?? '';
      final nacionalidade = _paisSelecionado ?? '';
      final clube = _clubeSelecionado ?? '';
      final genero = _generoSelecionado ?? '';

      final Map<String, dynamic> jogador = {
        "athleteId": DateTime.now().millisecondsSinceEpoch.toInt(),
        "fullName": nome,
        "dateOfBirth": DateFormat('dd/MM/yyyy').parse(dataNascimento).toIso8601String(),
        "nationality": nacionalidade,
        "position": posicao,
        "gender": genero,
        "teamId": _clubes.firstWhere((c) => c['teamName'] == clube)['teamId'],
        "agentId": 1
      };

      try {
        final response = await http.post(
          Uri.parse('http://192.168.1.66:3000/athletes'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(jogador),
        );

        if (response.statusCode == 201) {
          print('Jogador criado: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Jogador criado com sucesso!')),
          );
        } else {
          print('Erro na criação: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao criar jogador: ${response.body}')),
          );
        }
      } catch (e) {
        print('Erro de conexão: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro de conexão: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Jogador'),
        backgroundColor: Colors.black,
      ),
      body: _isLoadingClubes
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      _buildDropdownField(
                        'Clube',
                        _clubes.map((c) => c['teamName'] as String).toList(),
                        _clubeSelecionado,
                        (String? novoValor) {
                          _clubeSelecionado = novoValor;
                        },
                      ),
                      const SizedBox(height: 5),
                      _buildDropdownField('Género', _generos, _generoSelecionado, (String? novoValor) {
                        _generoSelecionado = novoValor;
                      }),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => _enviarDados(context),
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
              ),
            ),
    );
  }

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
        suffixIcon: const Icon(Icons.calendar_today),
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
          child: Text(_generosDisplay[value] ?? value),
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
