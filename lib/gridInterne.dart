import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';

class GridInterne extends StatelessWidget {
  final Puzzle puzzle;
  final int blockIndex;

  const GridInterne({super.key, required this.puzzle, required this.blockIndex});

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.height;
    double gridSize = screenSize * 0.9; // 90% de l'écran
    double cellSize = gridSize / 9; // Chaque cellule est 1/9 de la grille

    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(9, (cellIndex) {
        final int row = (blockIndex ~/ 3) * 3 + cellIndex ~/ 3;
        final int col = (blockIndex % 3) * 3 + cellIndex % 3;
        final int value = puzzle.board()?.matrix()?[row][col].getValue() ?? 0;

        return Container(
          width: cellSize,
          height: cellSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5), // Bordures fines
          ),
          child: Center(
            child: Text(
              value != 0 ? value.toString() : '', // Affiche uniquement les valeurs ≠ 0
              style: TextStyle(fontSize: cellSize * 0.6, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }),
    );
  }
}
