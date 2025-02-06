import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:sudoku_starter/gridInterne.dart';

class SudokuGrid extends StatefulWidget {
  const SudokuGrid({super.key});

  @override
  _SudokuGridState createState() => _SudokuGridState();
}

class _SudokuGridState extends State<SudokuGrid> {
  late Future<Puzzle> _puzzleFuture;
  int? _selectedCellIndex; // Variable pour suivre la cellule sélectionnée

  @override
  void initState() {
    super.initState();
    _puzzleFuture = _generatePuzzle();
  }

  Future<Puzzle> _generatePuzzle() async {
    PuzzleOptions options = PuzzleOptions(patternName: "winter");
    Puzzle puzzle = Puzzle(options);
    await puzzle.generate();
    return puzzle;
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.height;
    double gridSize = screenSize * 0.9; // La grille fait 90% de l'écran
    double borderSize = 2.0; // Bordures épaisses entre les blocs

    return Scaffold(
      appBar: AppBar(title: const Text('Sudoku')),
      body: FutureBuilder<Puzzle>(
        future: _puzzleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Center(
              child: Container(
                width: gridSize,
                height: gridSize,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: borderSize),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9, // 9 blocs de 3x3
                  itemBuilder: (context, blockIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: borderSize),
                      ),
                      child: GridInterne(
                        puzzle: snapshot.data!,
                        blockIndex: blockIndex,
                        selectedCellIndex: _selectedCellIndex,
                        onCellSelected: (int cellIndex) {
                          setState(() {
                            // Calculer l'indice global de la cellule sélectionnée
                            int globalCellIndex = blockIndex * 9 + cellIndex;
                            _selectedCellIndex = globalCellIndex;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(child: Text('Aucune donnée disponible.'));
          }
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SudokuGrid(),
  ));
}
