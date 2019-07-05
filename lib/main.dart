import 'package:flutter/material.dart';
import 'package:flutter_demo/zhihu/home.dart';
import 'package:flutter_demo/list.dart';
import 'package:flutter_demo/flare.dart';
import 'package:flutter_demo/camera.dart';

void main() => runApp(APP());

class APP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Demo",
        theme: ThemeData(primaryColor: Colors.blue),
        home: ZhihuHome());
  }
}
