import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = new math.Random();

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({this.imageURL, this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
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
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

// ==============
// Widgets
// ==============
/*
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
*/
void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

Tile tile = new Tile(
    imageURL: 'assets/images/0-Star-Wars-memes.jpeg',
    alignment: Alignment(0, 0));

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> containers = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        double x = -1 + i * (2 / (3 - 1));
        double y = -1 + j * (2 / (3 - 1));
        containers.add(Container(
          color: Colors.red,
          child: SizedBox(
              width: 100,
              height: 100,
              child: Container(
                  child: this.createTileWidgetFrom(tile, y, x, (1 / 3)))),
        ));
      }
    }
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
            child: GridView.count(
                /*primary: false,*/
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                crossAxisCount: 3,
                children: containers),
          ),
          FloatingActionButton(onPressed: swapTiles)
        ],
      ),
    );
  }

  swapTiles() {
    setState(() {
      containers.insert(1, containers.removeAt(0));
    });
  }

  Widget createTileWidgetFrom(Tile tile, double x, double y, double ratio) {
    return InkWell(
      child: tile.ThirdCroppedImageTile(x, y, ratio),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
