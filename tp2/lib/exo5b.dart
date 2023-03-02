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

  Widget SecondCroppedImageTile(double x, double y) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment(x, y),
            widthFactor: 0.33,
            heightFactor: 0.33,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

Tile tile = new Tile(
    imageURL: 'assets/images/0-Star-Wars-memes.jpeg',
    alignment: Alignment(0, 0));

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
                  width: 100,
                  height: 100,
                  child: Container(
                      child: this.createTileWidgetFrom(tile, -1, -1))),
            ),
            Container(
              color: Colors.orange,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child:
                      Container(child: this.createTileWidgetFrom(tile, 0, -1))),
            ),
            Container(
              color: Colors.yellow,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child:
                      Container(child: this.createTileWidgetFrom(tile, 1, -1))),
            ),
            Container(
              color: Colors.green,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child:
                      Container(child: this.createTileWidgetFrom(tile, -1, 0))),
            ),
            Container(
              color: Colors.blue,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child:
                      Container(child: this.createTileWidgetFrom(tile, 0, 0))),
            ),
            Container(
              color: Colors.pink,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child:
                      Container(child: this.createTileWidgetFrom(tile, 1, 0))),
            ),
            Container(
              color: Colors.purple,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child:
                      Container(child: this.createTileWidgetFrom(tile, -1, 1))),
            ),
            Container(
              color: Colors.grey,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child:
                      Container(child: this.createTileWidgetFrom(tile, 0, 1))),
            ),
            Container(
              color: Colors.brown,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child:
                      Container(child: this.createTileWidgetFrom(tile, 1, 1))),
            ),
          ],
        ),
      ),
    );
  }

  Widget createTileWidgetFrom(Tile tile, double x, double y) {
    return InkWell(
      child: tile.SecondCroppedImageTile(x, y),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
