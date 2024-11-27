import 'package:appviriatos/main.dart';
import 'package:flutter/material.dart';
import 'criarjogador.dart';
import 'tarefas.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Cor de fundo
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo e Bem-vindo
          Stack(
            alignment: Alignment.center,
            children: [
              // Retângulo horizontal atrás do logotipo
               Container(
                width: MediaQuery.of(context).size.width, // Garante largura total
                height: 170, // Altura do retangulo
                color: const Color.fromARGB(255, 0, 0, 0), // Cor do retangulo
              ),

              Container(
                width: MediaQuery.of(context).size.width, // Garante largura total
                height: 160, // Altura do retangulo
                color: const Color.fromARGB(255, 255, 255, 255), // Cor do retangulo
              ),

              Container(
                width: MediaQuery.of(context).size.width, // Garante largura total
                height: 130, // Altura do retangulo
                color: const Color.fromARGB(255, 0, 0, 0), // Cor do retangulo
              ),
              // Logotipo SVG
              SvgPicture.asset(
                'web/icons/LOGO Académico_Viseu_FC.svg', // Caminho do SVG
                height: 370, // Altura do logotipo
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
           'Bem-vindo',
            style: TextStyle(
              fontFamily: 'FuturaStd', // Nome da família definida no pubspec.yaml
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 50,
              fontWeight: FontWeight.bold, // Ainda pode manter o peso para consistência
                      ),
          ),
          SizedBox(height: 5),
         Text(
              'Acompanhe os jogos, navegue pelos\nescalões e controle seus assuntos\nfacilmente.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'FuturaStd', // Nome da família definido no pubspec.yaml
                color: const Color.fromARGB(179, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.w400, // Peso correspondente ao Book (400)
              ),
            ),
          SizedBox(height: 30),

          // Botões de navegação
          NavigationButton(
            icon: Icons.check_circle_outline,
            label: 'TAREFAS',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TarefasPage()),
              );
            },
          ),
          NavigationButton(
            icon: Icons.people_outline,
            label: 'CLUBES',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClubesPage()),
              );
            },
          ),
          NavigationButton(
            icon: Icons.person_add_alt_1_outlined,
            label: 'CRIAR JOGADOR',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CriarJogador()),
              );
            },
          ),
          NavigationButton(
            icon: Icons.note_alt_outlined,
            label: 'RASCUNHOS',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RascunhosPage()),
              );
            },
          ),
          NavigationButton(
            icon: Icons.logout,
            label: 'LOG-OUT',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const NavigationButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Alterado para 'backgroundColor'
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Tela para Tarefas
class TarefasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas')),
      body: Center(child: Text('Página de Tarefas')),
    );
  }
}

// Tela para Clubes
class ClubesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clubes')),
      body: Center(child: Text('Página de Clubes')),
    );
  }
}

// Tela para Criar Jogador
class CriarJogadorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar Jogador')),
      body: Center(child: Text('Página de Criar Jogador')),
    );
  }
}

// Tela para Rascunhos
class RascunhosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rascunhos')),
      body: Center(child: Text('Página de Rascunhos')),
    );
  }
}

// Tela para Log-out
class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log-out')),
      body: Center(child: Text('Página de Log-out')),
    );
  }
}
