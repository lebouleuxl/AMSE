import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = new math.Random();

class Tile {
  Color color;
  int NumeroTile;

  Tile(this.color);
  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
  Tile.choosenColor() {
    this.color = Colors.red;
  }
}

// ==============
// Widgets
// ==============

class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        child: Padding(
          padding: EdgeInsets.all(70.0),
        ));
  }
}

//void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> tiles =
      List<Widget>.generate(16, (index) => TileWidget(Tile.choosenColor()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving Tiles'),
        centerTitle: true,
      ),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          primary: false,
          itemCount: 16,
          itemBuilder: (BuildContext context, int i) {
            return container(tiles[i]);
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sentiment_very_satisfied), onPressed: swapTiles),
    );
  }

  Widget container(TileWidget tile) {
    return InkWell(
      child: tile.coloredBox(),
      onTap: () {
        setState(() {
          swapTiles();
        });
      },
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}
