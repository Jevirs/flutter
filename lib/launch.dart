import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var word = "刷新选择午饭";

  _refresh() async {
    var url = 'https://easy-mock.com/mock/5cebc5ae735a1d6408ec3ee2/demo/eat';
    var httpClient = HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        var length = data['data'].length;
        result = data['data'][Random().nextInt(length)];
      } else {
        result = '没找到吃的';
      }
    } catch (exception) {
      result = "没网只能吃二烧了";
    }
    if (!mounted) return;
    setState(() {
      word = result;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'YunjiFinance',
        home: Scaffold(
          appBar: AppBar(
            title: Text('吃啥呢'),
          ),
          body: Center(
            child: Text(word),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _refresh();
            },
            child: Icon(Icons.refresh),
            backgroundColor: Colors.pink,
          ),
        ),
      );
}
