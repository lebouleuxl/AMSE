import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = new math.Random();

class Tile {
  Color color;
  int NumeroTile;
  String nom;

  Tile(this.color);
  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
  Tile.choosenColor(int i) {
    this.color = Colors.red;
    this.NumeroTile = i;
    this.nom = 'Tile';
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
        child: Text(tile.nom + tile.NumeroTile.toString()),
        padding: const EdgeInsets.all(8),
        color: tile.color);
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
    emptyTile.tile.nom = 'Empty ';

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
      tw.tile.color = Colors.yellow;
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
    );
  }

  Widget container(TileWidget tile) {
    return InkWell(
      child: tile.coloredBox(),
      onTap: () {
        setState(() {
          swapTiles(tile);
        });
      },
    );
  }

  swapTiles(TileWidget tile) {
    adjacentTiles.forEach((tilewidget) {
      TileWidget tw = tilewidget;
      tw.tile.color = Colors.red;
    });

    int IndiceEmptyTile;
    int i = 0;
    tiles.forEach((tilewidget) {
      TileWidget tw = tilewidget;
      if (tw.tile.NumeroTile == 0) IndiceEmptyTile = i;
      i++;
    });

    int IndiceTile;
    int j = 0;
    tiles.forEach((tilewidget) {
      TileWidget tw = tilewidget;
      if (tw.tile.NumeroTile == tile.tile.NumeroTile) IndiceTile = j;
      j++;
    });

    TileWidget removeEmptyTile = tiles.removeAt(IndiceEmptyTile);
    tiles.insert(IndiceEmptyTile, tile);
    tiles.removeAt(IndiceTile);
    tiles.insert(IndiceTile, removeEmptyTile);
  }
}
