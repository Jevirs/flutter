import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/zhihu/detail.dart';
import 'package:flutter_demo/zhihu/home_model.dart';
import 'package:flutter_demo/zhihu/http.dart';

class HomeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ListState();
  }
}

class _ListState extends State<HomeList> {
  List<Story> stories = [];

  void getList() async {
    var res = await dio.get('/before/20190604');
    HomeData hotData = HomeData.fromJson(res.data);
    setState(() {
      stories = hotData.stories;
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    if (stories.length == 0) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new ListView.builder(
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return new Divider();
          }

          final i = index ~/ 2;
          final item = stories[i].toJson();

          return new ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: new Image.network(item['images'][0]),
            title: new Text(item['title']),
            onTap: () => {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new Scaffold(
                      body: new Container(
                        child: new Detail(id: item['id'].toString()),
                      ),
                    );
                  }))
                },
          );
        },
        itemCount: stories.length,
      );
    }
  }
}
