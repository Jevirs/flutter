import 'package:flutter/material.dart';
import 'package:flutter_demo/zhihu/home.dart';

void main() => runApp(new Zhihu());

class Zhihu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "知乎Hot",
        theme: new ThemeData(primaryColor: Colors.blue),
        home: new Home());
  }
}
