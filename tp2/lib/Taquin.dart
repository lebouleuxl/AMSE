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

  Tile.image(int i, String imageURL) {
    this.imageURL = imageURL;
    this.NumeroTile = i;
    alignment = Alignment(0, 0);
  }
}

// ==============
// Widgets
// ==============

class TileWidget extends StatelessWidget {
  final Tile tile;
  final double x;
  final double y;
  final double ratio;

  TileWidget(this.tile, this.x, this.y, this.ratio);

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget whiteBox() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        color: tile.color);
  }

  Widget coloredBox() {
    return Container(
        alignment: Alignment.center,
        child: ThirdCroppedImageTile(x, y, ratio),
        padding: const EdgeInsets.all(8),
        color: tile.color);
  }

  Widget ThirdCroppedImageTile(double x, double y, double ratio) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment(x, y),
            widthFactor: ratio,
            heightFactor: ratio,
            child: Image.network('assets/images/0-Star-Wars-memes.jpeg'),
          ),
        ),
      ),
    );
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
  int score = 0;

  @override
  Widget build(BuildContext context) {
    bool gagne;
    if (initialisation) {
      gagne = false;
      tiles = [];
      for (int i = 0; i < SliderValue * SliderValue; i++) {
        double x = -1 + (i ~/ SliderValue) * (2 / (SliderValue - 1));
        double y = -1 + (i % SliderValue) * (2 / (SliderValue - 1));
        tiles.add(TileWidget(
            Tile.image(i, 'assets/images/0-Star-Wars-memes.jpeg'),
            y,
            x,
            1 / SliderValue));
      }
      emptyTile = tiles[0];
      emptyTile.tile.imageURL = 'assets/images/blanc.jpg';

      for (int i = 0; i < 1000; i++) {
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

        TileWidget tileMelange =
            adjacentTiles[random.nextInt(adjacentTiles.length)];
        swapTiles(tileMelange, gagne);
      }
      score = 0;
    }

    gagne = true;
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
          title: Text(
              'Taquin : image, choix taille, décompte déplacement, message victoire'),
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
                      return container(tiles[i], gagne);
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
                      child: Text(
                          initialisation ? "Commencer partie" : "Recommencer")),
                  Text('Nb déplacements : $score')
                ],
              ),
            ]));
  }

  Widget container(TileWidget tile, bool gagne) {
    if (tile.tile.NumeroTile != 0) {
      return InkWell(
        child: tile.ThirdCroppedImageTile(tile.x, tile.y, tile.ratio),
        onTap: () {
          setState(() {
            swapTiles(tile, gagne);
          });
        },
      );
    } else {
      return InkWell(
        child: tile.whiteBox(),
      );
    }
  }

  swapTiles(TileWidget tile, bool gagne) {
    bool swapable = false;
    adjacentTiles.forEach((tilewidget) {
      TileWidget tw = tilewidget;
      if (tw.tile.NumeroTile == tile.tile.NumeroTile) {
        swapable = true;
      }
    });
    if (swapable) {
      score = score + 1;
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

      int k = 0;
      tiles.forEach((tilewidget) {
        TileWidget tw = tilewidget;
        if (tw.tile.NumeroTile != k) gagne = false;
        k++;
      });

      if (gagne) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(title: Text("Gagné"), actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK")),
              ]);
            });
      }
    }
  }
}
