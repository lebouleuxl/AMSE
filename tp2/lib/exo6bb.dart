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
  Tile.choosenColor(int i) {
    this.color = Colors.red;
    this.NumeroTile = i;
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
      alignment: Alignment.center,
      child: Text('Tile ' + tile.NumeroTile.toString()),
      color: tile.color,
      padding: EdgeInsets.all(70.0),
    );
  }
}

//void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  int SliderValue = 4;
  TileWidget emptyTile;
  List<Widget> adjacentTiles;
  List<Widget> tiles = List<Widget>.generate(
      16, (index) => TileWidget(Tile.choosenColor(index)));

  void initState() {
    emptyTile = tiles[0 /*random.nextInt(tiles.length)*/];
    emptyTile.tile.color = Colors.white;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    adjacentTiles = [];

    int IndiceEmptyTile;
    int i = 0;
    tiles.forEach((tilewidget) {
      TileWidget tw = tilewidget;
      if (tw.tile.NumeroTile == 0) IndiceEmptyTile = i;
      i++;
    });

    if (IndiceEmptyTile % SliderValue != 0)
      adjacentTiles.add(tiles[IndiceEmptyTile - 1]);
    if (IndiceEmptyTile % SliderValue != SliderValue - 1)
      adjacentTiles.add(tiles[IndiceEmptyTile + 1]);
    if (IndiceEmptyTile + SliderValue < tiles.length)
      adjacentTiles.add(tiles[IndiceEmptyTile + SliderValue]);
    if (IndiceEmptyTile - SliderValue >= 0)
      adjacentTiles.add(tiles[IndiceEmptyTile - SliderValue]);

    adjacentTiles.forEach((tilewidget) {
      TileWidget tw = tilewidget;
      tw.tile.color = Colors.black;
    });

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
      adjacentTiles.forEach((tilewidget) {
        TileWidget tw = tilewidget;
        tw.tile.color = Colors.red;
      });
    });
  }
}
