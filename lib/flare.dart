import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlareDemo',
      home: Scaffold(
          appBar: AppBar(
            title: Text('FlareDemo'),
          ),
          body: Home()),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // FlareControls _controller = FlareControls();
  String _animationName = '';
  void _playAnimation() {
    setState(() {
      _animationName = 'scan';
    });
  }

  void _clearAnimation() {
    setState(() {
      _animationName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            alignment: Alignment.center,
            child: FlareActor(
              'assets/scan.flr',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              animation: _animationName,
              callback: (animationName) {
                print(animationName);
                _clearAnimation();
              },
            ),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(12.0)),
          ),
          RaisedButton(
            child: Text('Scan!'),
            onPressed: () => {_playAnimation()},
          )
        ],
      )),
    );
  }
}
