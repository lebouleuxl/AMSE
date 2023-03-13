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
  String imageURL;
  Alignment alignment;

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
  static const InitSliderValue = 3;
  int SliderValue = InitSliderValue;
  TileWidget emptyTile;
  List<Widget> adjacentTiles;
  bool initialisation = true;
  List<Widget> tiles;
  bool isSliderEnabled = true;

  @override
  Widget build(BuildContext context) {
    if (initialisation) {
      tiles = [];
      for (int i = 0; i < SliderValue * SliderValue; i++) {
        tiles.add(TileWidget(Tile.choosenColor(i)));
      }
      emptyTile = tiles[0 /*random.nextInt(tiles.length)*/];
      emptyTile.tile.color = Colors.white;
      emptyTile.tile.nom = 'Empty ';
    }

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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 400,
                height: 400,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: SliderValue),
                    primary: false,
                    itemCount: SliderValue * SliderValue,
                    itemBuilder: (BuildContext context, int i) {
                      return container(tiles[i]);
                    }),
              ),
              Row(children: <Widget>[
                Text("Size : "),
                Expanded(
                  child: Slider(
                    value: SliderValue.toDouble(),
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: SliderValue.round().toString(),
                    onChanged: initialisation
                        ? (double value) {
                            setState(() {
                              SliderValue = value.toInt();
                            });
                          }
                        : null,
                  ),
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          initialisation = !initialisation;
                        });
                      },
                      child: Text(initialisation
                          ? "Commencer partie"
                          : "Enable Slider")),
                ],
              ),
            ]));
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
