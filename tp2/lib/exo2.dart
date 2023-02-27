/* clipper, contenair, rendre plus beau transform*/

import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
import 'dart:math';

class SliderExample extends StatefulWidget {
  const SliderExample({key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _currentSliderPrimaryValue = 0;
  double _currentSliderSecondaryValue = 0;
  bool isChecked = false;
  double miroir = 1.0;
  double _currentSliderThirdaryValue = 1;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.blue;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Slider')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform(
            transform: Matrix4.identity()..scale(miroir, 1.0, 1.0),
            alignment: FractionalOffset.center,
            child: Transform(
              transform: Matrix4.rotationY(_currentSliderSecondaryValue),
              child: Transform.rotate(
                angle: _currentSliderPrimaryValue,
                child: Transform.scale(
                  scale: _currentSliderThirdaryValue,
                  child: Image.asset(
                    'assets/images/vaccinRNA.png',
                    width: 350,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Row(children: <Widget>[
            Text("RotateX : "),
            Expanded(
              child: Slider(
                value: _currentSliderPrimaryValue,
                min: 0,
                max: 360,
                label: _currentSliderPrimaryValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderPrimaryValue = value;
                  });
                },
              ),
            )
          ]),
          Row(children: <Widget>[
            Text("RotateZ : "),
            Expanded(
              child: Slider(
                value: _currentSliderSecondaryValue,
                min: 0,
                max: 360,
                label: _currentSliderSecondaryValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderSecondaryValue = value;
                  });
                },
              ),
            )
          ]),
          Row(children: <Widget>[
            Text("Mirror : "),
            Expanded(
              child: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool value) {
                  setState(() {
                    isChecked = value;
                    if (value) {
                      miroir = -1.0;
                    } else {
                      miroir = 1.0;
                    }
                  });
                },
              ),
            )
          ]),
          Row(children: <Widget>[
            Text("Scale : "),
            Expanded(
              child: Slider(
                value: _currentSliderThirdaryValue,
                min: 0,
                max: 2,
                label: _currentSliderThirdaryValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderThirdaryValue = value;
                  });
                },
              ),
            )
          ]),
        ],
      ),
    );
  }
}
