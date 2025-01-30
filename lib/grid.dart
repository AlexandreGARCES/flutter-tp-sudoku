import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    final double boxSize = MediaQuery.of(context).size.width / 6;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku game'),
      ),
      body: Center(
        child: SizedBox(
          width: boxSize * 3,
          height: boxSize * 3,
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(9, (x) {
              return Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Grid(),
  ));
}