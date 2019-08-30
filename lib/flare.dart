import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    title: 'flare',
    home: FlareHome(),
  ));
}

class FlareHome extends StatefulWidget {
  FlareHome({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<FlareHome> {
  /* animation */
  String _animationName = '';

  void _playAnimation(String name) {
    setState(() {
      _animationName = name;
    });
  }

  void _clearAnimation() {
    setState(() {
      _animationName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flare'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                width: 600,
                height: 400,
                child: FlareActor('assets/sun.flr',
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    animation: _animationName, callback: (animationName) {
                  print(animationName);
                  _clearAnimation();
                })),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('sun'),
                  onPressed: () => _playAnimation('sun'),
                ),
                RaisedButton(
                  child: Text('moon'),
                  onPressed: () => _playAnimation('moon'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
