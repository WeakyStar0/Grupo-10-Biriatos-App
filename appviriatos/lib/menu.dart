import 'package:appviriatos/main.dart';
import 'package:flutter/material.dart';



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
      backgroundColor: Colors.grey[850], // Cor de fundo
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo e Bem-vindo
              Column(
                children: [
                  Image.asset(
                    'LOGO Académico_Viseu_FC.svg', // Substitua pelo caminho da sua imagem de logo
                    height: 80,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bem-vindo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Acompanhe os jogos, navegue pelos\nescalões e controle seus assuntos\nfacilmente.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
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
                    MaterialPageRoute(builder: (context) => CriarJogadorPage()),
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
        ),
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
          backgroundColor: Colors.black, // Alterado para 'backgroundColor'
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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