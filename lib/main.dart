import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var word = new WordPair.random().asLowerCase;

    void _refresh() {
      setState(() {
        word = new WordPair.random().asLowerCase;
      });
    }

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

class MyWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<MyWords> {
  var name = new WordPair.random().asUpperCase;

  void _refresh() {
    setState(() {
      name = new WordPair.random().asUpperCase;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Text(name);
  }
}
