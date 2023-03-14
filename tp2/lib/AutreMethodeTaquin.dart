import 'package:flutter/material.dart';
import 'dart:math';

class AutreMethodeTaquin extends StatefulWidget {
  @override
  _AutreMethodeTaquinState createState() => _AutreMethodeTaquinState();
}

class _AutreMethodeTaquinState extends State<AutreMethodeTaquin> {
  List<int> tiles;
  int size = 3;
  final random = Random();
  bool isSolved = false;

  @override
  void initState() {
    super.initState();
    resetPuzzle();
  }

  void resetPuzzle() {
    setState(() {
      tiles = List.generate(size * size, (i) => i);
      tiles.shuffle(random); //Pas sur qu'il y ait une solution
      isSolved = false;
    });
  }

  void move(int index) {
    setState(() {
      final emptyIndex = tiles.indexOf(0);
      if (isAdjacent(emptyIndex, index)) {
        tiles[emptyIndex] = tiles[index];
        tiles[index] = 0;
        isSolved = checkSolved();
      }
    });
  }

  bool isAdjacent(int index1, int index2) {
    return (index1 - index2).abs() == 1 || (index1 - index2).abs() == size;
  }

  bool checkSolved() {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentative dune autre méthode pour créer le taquin'),
      ),
      body: GridView.count(
        crossAxisCount: size,
        children: tiles
            .asMap()
            .map((index, value) => MapEntry(
                index,
                GestureDetector(
                  onTap: () => move(index),
                  child: Container(
                    color: value != 0 ? Colors.red : Colors.white,
                    child: Center(
                        child: Text(
                      value != 0 ? '$value' : '',
                      //style: TextStyle(fontSize: 32),
                    )),
                  ),
                )))
            .values
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Taille du taquin"),
                  content: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        size = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Entrez un nombre",
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          resetPuzzle();
                          Navigator.pop(context);
                        },
                        child: Text("OK")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Annuler")),
                  ],
                );
              });
        },
        child: Icon(Icons.settings),
      ),
    );
  }
}
