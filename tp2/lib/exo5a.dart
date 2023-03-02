import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
import 'dart:math';

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
}

Tile tile =
    new Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 0));

class GridViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridViewTest'),
      ),
      body: Center(
        child: GridView.count(
          /*primary: false,*/
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 3,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: Container(child: this.createTileWidgetFrom(tile))),
            ),
            Container(
              color: Colors.orange,
              child: SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: Container(child: this.createTileWidgetFrom(tile))),
            ),
            Container(
              color: Colors.yellow,
              child: const Text('Tile 3'),
            ),
            Container(
              color: Colors.green,
              child: const Text('Tile 4'),
            ),
            Container(
              color: Colors.blue,
              child: const Text('Tile 5'),
            ),
            Container(
              color: Colors.pink,
              child: const Text('Tile 6'),
            ),
            Container(
              color: Colors.purple,
              child: const Text("Tile 7"),
            ),
            Container(
              color: Colors.grey,
              child: const Text('Tile 8'),
            ),
            Container(
              color: Colors.brown,
              child: const Text('Tile 9', textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
