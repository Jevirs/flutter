import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() => MyAppState();
}

SharedPreferences prefs;
TextEditingController _controller = TextEditingController(text: "");
TextEditingController _controller2 = TextEditingController(text: "");

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _asyncInit();
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  _asyncInit() async {
    prefs = await SharedPreferences.getInstance();
    String code = prefs.getString("code");
    String cookie = prefs.getString("cookie");

    _controller.text = code;
    _controller2.text = cookie;
  }

  _save() async {
    String code = _controller.text;
    String cookie = _controller2.text;
    prefs.setString("code", code);
    prefs.setString("cookie", cookie);
    showToast("保存成功");
  }

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
                    Text("DIDI打卡",
                        style: TextStyle(color: Colors.black, fontSize: 36)),
                    TextField(
                      controller: _controller,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        hintText: '请输入工号',
                      ),
                    ),
                    TextField(
                      controller: _controller2,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(hintText: '请输入JESSIONID值'),
                    ),
                    RaisedButton(
                      onPressed: () => {_save()},
                      child: Text("保存"),
                      textColor: Colors.black,
                      focusColor: Colors.red,
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
    void showToast(String msg, {int duration, int gravity}) {
      Toast.show(msg, context, duration: duration, gravity: gravity);
    }

    _didi() async {
      String result;
      var _url = 'http://attendance.' +
          'yunjiglobal' +
          '.com/attendance/attendance/check?workcode=';
      var url = _url + _controller.text;
      var httpClient = HttpClient();
      try {
        var request = await httpClient.getUrl(Uri.parse(url));
        request.headers.add("user-agent",
            "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
        request.headers.add("cookie", _controller2.text);
        var response = await request.close();
        print(response.toString());
        if (response.statusCode == HttpStatus.ok) {
          result = "成功了";
        } else {
          result = '失败了';
        }
      } catch (exception) {
        result = "有网吗？";
      }
      httpClient.close();
      showToast(result);
    }

    return FloatingActionButton(
      onPressed: () => {_didi()},
      child: Icon(Icons.check),
      backgroundColor: Colors.blue,
    );
  }
}
