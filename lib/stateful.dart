import 'package:flutter/material.dart';

void main() => runApp(MyStatefulWidget());

// 定义一个有状态的组件
class MyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyStatefulWidgetState();
  }
}

// 定义一个有状态的组件时，必须为该组件创建一个状态类，这个类继承自State类
class MyStatefulWidgetState extends State<MyStatefulWidget> {
  String text = "Click Me!";

  changeText() {
    if (text == "Click Me!") {
      setState(() {
        text = "Hello World!";
      });
    } else {
      setState(() {
        text = "Click Me!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: Center(
          // InkWell是Flutter内置的一个Widget，用于给其他Widget添加点击事件，并且在点击时会有水波纹扩散效果
          child: InkWell(
            child: Text(text),
            onTap: () {
              this.changeText();
            },
          ),
        ),
      ),
    );
  }
}
