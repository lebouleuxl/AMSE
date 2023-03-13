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

class TileWidget extends StatelessWidget {
  final Tile tile;
  double x;
  double y;

  TileWidget(this.tile, this.x, this.y);

  @override
  Widget build(BuildContext context) {
    return this.coloredBox(x, y);
  }

  Widget createTileWidgetFrom(Tile tile, double x, double y, double ratio) {
    return InkWell(
      child: tile.ThirdCroppedImageTile(x, y, ratio),
      onTap: () {
        print("tapped on tile");
      },
    );
  }

  Widget coloredBox(x, y) {
    return Container(
      color: Colors.red,
      child: SizedBox(
          width: 100,
          height: 100,
          child:
              Container(child: this.createTileWidgetFrom(tile, y, x, (1 / 3)))),
    );
  }
}

void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

Tile tile = new Tile(
    imageURL: 'assets/images/0-Star-Wars-memes.jpeg',
    alignment: Alignment(0, 0));

Tile tile2 = new Tile(
    imageURL: 'assets/images/vaccinRNA.png', alignment: Alignment(0, 0));

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> tiles = [];

  void changeRandomTileColor() {
    int randomIndex = random.nextInt(2);
    setState(() {
      tiles[randomIndex] = TileWidget(tile2, 0, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        double x = -1 + i * (2 / (3 - 1));
        double y = -1 + j * (2 / (3 - 1));
        tiles.add(TileWidget(tile, x, y));
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
                children: tiles),
          ),
          FloatingActionButton(
            onPressed: () {
              changeRandomTileColor();
            },
            child: Text("Button"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sentiment_very_satisfied), onPressed: swapTiles),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}
