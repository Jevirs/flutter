import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() => MyAppState();
}

String result = '???';
TextEditingController _controller = TextEditingController(text: "2097");

_didi(BuildContext context) async {
  var _url = '';
  var url = _url + _controller.text;
  var httpClient = HttpClient();
  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      result = "成功了";
    } else {
      result = '失败了';
    }
  } catch (exception) {
    result = "有网吗？";
  }
  _showToast(context);
}

_showToast(BuildContext context) {
  print(result);
  Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(result), backgroundColor: Colors.blue));
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'DIDI',
        home: Scaffold(
            appBar: AppBar(
              title: Text('DIDI'),
            ),
            body: Center(
                child: Padding(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text("DIDI Helper",
                        style: TextStyle(color: Colors.black, fontSize: 36)),
                    TextField(
                      controller: _controller,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        hintText: '请输入工号',
                      ),
                    )
                  ],
                ),
              ),
              padding: EdgeInsets.all(32),
            )),
            floatingActionButton: FatButton()),
      );
}

class FatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {_didi(context)},
      child: Icon(Icons.check),
      backgroundColor: Colors.blue,
    );
  }
}
