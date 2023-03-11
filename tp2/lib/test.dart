import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
//import 'dart:math';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double _sliderValue = 1.0;

  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [];

    for (int i = 0; i < _sliderValue; i++) {
      containers.add(Container(
        width: 50,
        height: 50,
        color: Colors.blue,
        margin: EdgeInsets.all(10),
      ));
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: _sliderValue,
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: containers,
          ),
        ],
      ),
    );
  }
}
