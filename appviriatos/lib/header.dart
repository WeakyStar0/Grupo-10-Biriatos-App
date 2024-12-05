import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;

  const CustomHeader({
    Key? key,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255), // Fundo branco para o header
      padding: const EdgeInsets.only(top: 25.0), // Espaço superior
      child: Stack(
        clipBehavior: Clip.none, // Permite que o logotipo ultrapasse os limites
        alignment: Alignment.center,
        children: [
          // Retângulo maior (fundo preto)
          Container(
            width: MediaQuery.of(context).size.width, // Largura total
            height: 67, // Altura do retângulo
            color: const Color.fromARGB(255, 0, 0, 0), // Preto
          ),
          // Retângulo branco no meio
          Container(
            width: MediaQuery.of(context).size.width, // Largura total
            height: 60, // Altura do retângulo
            color: const Color.fromARGB(255, 255, 255, 255), // Branco
          ),
          // Retângulo menor (preto no topo)
          Container(
            width: MediaQuery.of(context).size.width, // Largura total
            height: 45, // Altura do retângulo
            color: const Color.fromARGB(255, 0, 0, 0), // Preto
          ),
          // Logotipo SVG (fora dos retângulos) com GestureDetector
          Positioned(
            top: -22, // Ajuste para o logotipo ficar acima do topo dos retângulos
            left: 50, // Ajuste horizontal (distância da borda esquerda)
            child: GestureDetector(
              onTap: () {
                // Substitua a navegação pela lógica necessária para sua página principal
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', // Rota inicial (main.dart)
                  (Route<dynamic> route) => false,
                );
              },
              child: SvgPicture.asset(
                'web/icons/LOGO_Academico_Viseu_FC_fixed.svg',
                height: 110, // Altura maior para destacar o logotipo
                semanticsLabel: 'Logotipo Académico de Viseu FC',
                placeholderBuilder: (BuildContext context) =>
                    const CircularProgressIndicator(),
              ),
            ),
          ),
          // Botão de voltar
          Positioned(
            left: 8.0, // Deslocar botão para a esquerda
            top: 13.5, // Alinhamento vertical
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0); // Altura do header
}
