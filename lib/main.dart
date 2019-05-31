import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  var word = "刷新选择午饭";

  _refresh() async {
    var url = 'https://easy-mock.com/mock/5cebc5ae735a1d6408ec3ee2/demo/eat';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        var length = data['data'].length;
        final _random = new Random();
        int next(int min, int max) => min + _random.nextInt(max - min);
        result = data['data'][next(0, length)];
      } else {
        result = '没东东';
      }
    } catch (exception) {
      result = exception.toString();
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      word = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'YunjiFinance',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('吃啥呢'),
        ),
        body: new Center(
          child: new Text(word),
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
}
