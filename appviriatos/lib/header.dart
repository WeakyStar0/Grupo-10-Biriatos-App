import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  final VoidCallback onProfile;

  const CustomHeader({
    Key? key,
    required this.onBack,
    required this.onProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Botão de voltar
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          // Logótipo no centro
          Image.asset(
            'assets/shield.png', // Substitui pelo caminho correto do logótipo
            height: 40,
          ),
          // Botão de perfil
          IconButton(
            onPressed: onProfile,
            icon: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // Altura do header
}
