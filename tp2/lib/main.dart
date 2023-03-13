import 'package:flutter/material.dart';

// import 'util.dart';
import 'exo1.dart' as exo1;
import 'exo2.dart' as exo2;
import 'exo4.dart' as exo4;
import 'exo5a.dart' as exo5a;
import 'exo5b.dart' as exo5b;
import 'exo5c.dart' as exo5c;
import 'test.dart' as test;
import 'exo6.dart' as exo6;
import 'exo6ba.dart' as exo6ba;
import 'exo6b.dart' as exo6b;
import 'Taquin.dart' as Taquin;
import 'AutreMethodeTaquin.dart' as AutreMethodeTaquin;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MenuPage());
  }
}

class Exo {
  final String title;
  final String subtitle;
  final WidgetBuilder buildFunc;

  const Exo({@required this.title, this.subtitle, @required this.buildFunc});
}

List exos = [
  Exo(
      title: 'Exercice 1',
      subtitle: 'Simple image',
      buildFunc: (context) => exo1.DisplayImageWidget()),
  Exo(
      title: 'Exercice 2',
      subtitle: 'Rotate&Scale image',
      buildFunc: (context) => exo2.SliderExample()),
  Exo(
      title: 'Exercice 4',
      subtitle: 'Rotate&Scale image',
      buildFunc: (context) => exo4.DisplayTileWidget()),
  Exo(
      title: 'Exercice 5a',
      subtitle: 'Rotate&Scale image',
      buildFunc: (context) => exo5a.GridViewTest()),
  Exo(
      title: 'Exercice 5b',
      subtitle: 'Rotate&Scale image',
      buildFunc: (context) => exo5b.GridViewTest()),
  Exo(
      title: 'Exercice 5c',
      subtitle: 'Slider',
      buildFunc: (context) => exo5c.SliderExample()),
  Exo(
      title: 'test',
      subtitle: 'Rotate&Scale image',
      buildFunc: (context) => test.MyWidget()),
  Exo(
      title: 'Exercice 6',
      subtitle: 'Swip deux carrés de couleur',
      buildFunc: (context) => exo6.PositionedTiles()),
  Exo(
      title: 'Tentative Taquin',
      subtitle: 'Slider qui devient non dispo',
      buildFunc: (context) => exo6ba.SliderExample()),
  Exo(
      title: 'exo 6b',
      subtitle: 'Taquin 4*4 szns image',
      buildFunc: (context) => exo6b.PositionedTiles()),
  Exo(
      title: 'Taquin',
      subtitle: 'Taquin',
      buildFunc: (context) => Taquin.PositionedTiles()),
  Exo(
      title: 'Autre méthode taquin',
      subtitle: 'Tentative dune autre méthode pour créer le taquin',
      buildFunc: (context) => AutreMethodeTaquin.AutreMethodeTaquin()),
];

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TP2'),
        ),
        body: ListView.builder(
            itemCount: exos.length,
            itemBuilder: (context, index) {
              var exo = exos[index];
              return Card(
                  child: ListTile(
                      title: Text(exo.title),
                      subtitle: Text(exo.subtitle),
                      trailing: Icon(Icons.play_arrow_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: exo.buildFunc),
                        );
                      }));
            }));
  }
}
