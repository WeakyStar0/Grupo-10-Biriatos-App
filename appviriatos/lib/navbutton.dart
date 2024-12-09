import 'package:flutter/material.dart';
import 'clubes.dart';
import 'rascunhos.dart';
import 'tarefas.dart';

class CustomFloatingButton extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomFloatingButton({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => onTap(0),
              iconSize: 32.0,
              icon: Icon(
                Icons.group,
                color: currentIndex == 0 ? Colors.white : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () => onTap(1),
              iconSize: 32.0,
              icon: Icon(
                Icons.task,
                color: currentIndex == 1 ? Colors.white : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () => onTap(2),
              iconSize: 32.0,
              icon: Icon(
                Icons.sports_soccer,
                color: currentIndex == 2 ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lógica central de navegação
void navigateToPage(BuildContext context, int index) {
  if (index == 0) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ClubesPage()),
    );
  } else if (index == 1) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RascunhosPage()),
    );
  } else if (index == 2) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TarefasPage()),
    );
  }
}
