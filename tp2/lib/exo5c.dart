import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
//import 'dart:math';

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

class SliderExample extends StatefulWidget {
  const SliderExample({key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

Tile tile = new Tile(
    imageURL: 'assets/images/0-Star-Wars-memes.jpeg',
    alignment: Alignment(0, 0));

class _SliderExampleState extends State<SliderExample> {
  double _sliderValue = 3;

  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [];

    for (int i = 0; i < _sliderValue; i++) {
      for (int j = 0; j < _sliderValue; j++) {
        double x = -1 + i * (2 / (_sliderValue - 1));
        double y = -1 + j * (2 / (_sliderValue - 1));
        containers.add(Container(
          color: Colors.red,
          child: SizedBox(
              width: 100,
              height: 100,
              child: Container(
                  child: this
                      .createTileWidgetFrom(tile, y, x, (1 / _sliderValue)))),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Plateau de tuiles avec slider de taille'),
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
                crossAxisCount: _sliderValue.toInt(),
                children: containers),
          ),
          Row(children: <Widget>[
            Text("Size : "),
            Expanded(
              child: Slider(
                value: _sliderValue,
                min: 0,
                max: 10,
                divisions: 10,
                label: _sliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
            )
          ]),
        ],
      ),
    );
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
