import 'package:flutter/material.dart';
import 'list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("知乎Hot"),
        ),
        body: new Container(
          padding: const EdgeInsets.all(16.0),
          child: new HomeList(),
        ));
  }
}
