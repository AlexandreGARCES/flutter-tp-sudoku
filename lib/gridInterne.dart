import 'package:flutter/material.dart';

class GridInterne extends StatelessWidget {
  const GridInterne({super.key});

  @override
  Widget build(BuildContext context) {
    final double cellSize = MediaQuery.of(context).size.width / 18;

    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.zero,
      children: List.generate(9, (index) {
        return Container(
          width: cellSize,
          height: cellSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.3),
          ),
          child: const Center(child: Text('T')),
        );
      }),
    );
  }
}
